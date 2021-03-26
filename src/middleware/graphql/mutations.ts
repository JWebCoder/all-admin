import { buildDeleteMutationType, buildType } from './typeBuilder'
import config from '../utils/configLoader'
import Debug from 'debug'
import { GraphQLFieldConfig, GraphQLFieldConfigMap, GraphQLList } from 'graphql'
import { capitalize, extractManyToManyRelatedData, getEntityConfig, getFields, getPKs } from '../utils/index'
import { executeHook } from '../utils/lifeCycle'
import { normalize } from '../utils/data'
import { update, create, remove } from '../dataConnector/index'
import { buildArgs } from './argumentsBuilder'
import type { ICreateArgs, IRemoveArgs, IUpdateArgs, relatedData } from '../../types/connector'
import type { IFilter } from '../utils/filter'
import type { IEntityInfo } from '../..//generator/configurationTypes'
import type { SchemaManager, TSchemaOptions } from './manager'
import { Funfunz } from '../../middleware/index'

const debug = Debug('funfunz:graphql-mutation-builder')

export function buildMutations<OptionsContext>(
  schemaManager: SchemaManager<OptionsContext>,
  options: TSchemaOptions<OptionsContext>
): GraphQLFieldConfigMap<unknown, unknown> {
  const configs = config()
  const mutations: GraphQLFieldConfigMap<unknown, unknown> = {}
  configs.entities.forEach((entity) => {
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    const dataConnector = configs.config.connectors[typeof entity.connector === 'string' ? entity.connector : entity.connector.name].connector
    mutations[`add${capitalize(entity.name)}`] = buildAddMutation(entity, schemaManager, options, typeof dataConnector.addMutation === 'function' && dataConnector.addMutation(entity))
    mutations[`update${capitalize(entity.name)}`] = buildUpdateMutation(entity, schemaManager, options, typeof dataConnector.updateMutation === 'function' && dataConnector.updateMutation(entity))
    mutations[`delete${capitalize(entity.name)}`] = buildDeleteMutation(entity, schemaManager, options, typeof dataConnector.deleteMutation === 'function' && dataConnector.deleteMutation(entity))
  })
  debug('Mutations built')
  return mutations
}

function buildUpdateMutation<OptionsContext>(
  entity: IEntityInfo,
  schemaManager: SchemaManager<OptionsContext>,
  options: TSchemaOptions<OptionsContext>,
  dataConnectorMutation?: GraphQLFieldConfig<unknown, unknown>
): GraphQLFieldConfig<unknown, unknown> {
  debug(`Creating ${entity.name} update mutation`)
  const mutation: GraphQLFieldConfig<unknown, unknown>  = {
    type: dataConnectorMutation?.type || new GraphQLList(buildType(entity, schemaManager, options, { relations: true })),
    args: dataConnectorMutation?.args || buildArgs(entity, { pagination: true, data: true, filter: true }),
    resolve: async (parent, rawargs, requestContext, info) => {
      const { args, context } = await executeHook(entity, 'update', 'beforeResolver', { args: rawargs, requestContext }, options, schemaManager.getSchemas())
      const data = normalize(args.data as Record<string, unknown>, entity)
      const fields = getFields(entity, info)
      const filter = args.filter || undefined
      const rawquery = {
        entityName: entity.name,
        fields,
        filter: filter as IFilter,
        data: data as Record<string, unknown>,
        skip: args.skip,
        take: args.take
      }
      const { query, context: newContext } = await executeHook(entity, 'update', 'beforeSendQuery', { args, query: rawquery, context, requestContext }, options, schemaManager.getSchemas())
      
      const results = await update(typeof entity.connector === 'string' ? entity.connector : entity.connector.name, query as IUpdateArgs)
      
      const { results: modifiedResults } = await executeHook(
        entity,
        'update',
        'afterQueryResult',
        {
          requestContext,
          args,
          query,
          results,
          context: newContext
        },
        options,
        schemaManager.getSchemas()
      )
      return modifiedResults
    }
  }
  debug(`Created ${entity.name} add mutation`)
  return mutation
}

function buildAddMutation<OptionsContext>(
  entity: IEntityInfo,
  schemaManager: SchemaManager<OptionsContext>,
  options: TSchemaOptions<OptionsContext>,
  dataConnectorMutation?: GraphQLFieldConfig<unknown, unknown>
): GraphQLFieldConfig<unknown, unknown> {
  debug(`Creating ${entity.name} add mutation`)
  const mutation: GraphQLFieldConfig<unknown, unknown> = {
    type: dataConnectorMutation?.type || new GraphQLList(buildType(entity, schemaManager, options)),
    args: dataConnectorMutation?.args || buildArgs(entity, { data: true }),
    resolve: async (parent, rawargs, requestContext, info) => {
      const schemas = schemaManager.getSchemas()
      const { args, context } = await executeHook(entity, 'add', 'beforeResolver', { args: rawargs, requestContext }, options, schemas)
      const data = normalize(args.data as Record<string, unknown>, entity)
      const fields = getFields(entity, info)

      const newDataset = extractManyToManyRelatedData(data, entity)

      const rawquery: ICreateArgs = {
        entityName: entity.name,
        fields,
        data: newDataset.entityData,
        relatedData: newDataset.relatedData,
        skip: args.skip as number,
        take: args.take as number
      }
      const { query, context: newContext } = await executeHook(entity, 'add', 'beforeSendQuery', { args, query: rawquery, context, requestContext }, options, schemas)
      const results = await create(typeof entity.connector === 'string' ? entity.connector : entity.connector.name, query as ICreateArgs) as Record<string, unknown>[]
      console.log('results', results)
      if (rawquery.relatedData) {
        const configs = config()
        await Promise.all(Object.keys(rawquery.relatedData).map(
          (entity) => {
            const entityRelatedData = (rawquery.relatedData as relatedData)[entity]
            const localPrimaryKey = entityRelatedData.localPrimaryKey || getPKs(getEntityConfig(entity, configs))[0]
            const mutationName = `add${entityRelatedData.relationalEntity.charAt(0).toUpperCase() + entityRelatedData.relationalEntity.slice(1)}`
            return Funfunz.executeGraphQL(schemas.api, `
              mutation {
                ${mutationName} (
                  data: {
                    ${entityRelatedData.remoteForeignKey}: ${entityRelatedData.value}
                    ${entityRelatedData.foreignKey}: ${results[0][localPrimaryKey]}
                  }
                ){
                  ${entityRelatedData.foreignKey}
                  ${entityRelatedData.remoteForeignKey}
                }
              }
            `).then(
              (result) => {
                console.log('result', result)
                return {
                  result: (result.data?.[mutationName] as Array<Record<string, unknown>>)[0],
                  entity
                }
              }
            ).catch(
              () => {
                return undefined
              }
            )
          }
        )).then(
          (results) => {
            console.log('second results', results)
            if (!results) {
              return {}
            }
            return results.reduce(
              (previous, current) => {
                if (!current) {
                  return previous
                }
                return previous[current.entity] = current.result
              },
              {}
            )
          }
        )
      }
      const { results: modifiedResults } = await executeHook(
        entity,
        'add',
        'afterQueryResult',
        {
          args,
          query,
          results: results,
          context: newContext,
          requestContext
        },
        options,
        schemas
      )
      return modifiedResults
    }
  }
  debug(`Created ${entity.name} add mutation`)
  return mutation
}

function buildDeleteMutation<OptionsContext>(
  entity: IEntityInfo,
  schemaManager: SchemaManager<OptionsContext>,
  options: TSchemaOptions<OptionsContext>,
  dataConnectorMutation?: GraphQLFieldConfig<unknown, unknown>,
): GraphQLFieldConfig<unknown, unknown> {
  debug(`Creating ${entity.name} delete mutation`)
  const mutation: GraphQLFieldConfig<unknown, unknown>  = {
    type: dataConnectorMutation?.type || buildDeleteMutationType(entity),
    args: dataConnectorMutation?.args || buildArgs(entity, { filter: true }),
    resolve: async (parent, rawargs, requestContext) => {
      const { args, context } = await executeHook(entity, 'delete', 'beforeResolver', { args: rawargs, requestContext }, options, schemaManager.getSchemas())
      const rawquery: IRemoveArgs = {
        entityName: entity.name,
        filter: args.filter as IFilter
      }
      const { query, context: newContext } = await executeHook(entity, 'delete', 'beforeSendQuery', { args, query: rawquery, context, requestContext }, options, schemaManager.getSchemas())

      const deleted = await remove(typeof entity.connector === 'string' ? entity.connector : entity.connector.name, query as IRemoveArgs)
      const results = { deleted }

      const { results: modifiedResults } = await executeHook(
        entity,
        'delete',
        'afterQueryResult',
        {
          args,
          query,
          results,
          context: newContext,
          requestContext,
        },
        options,
        schemaManager.getSchemas()
      )
      return modifiedResults
    },
  }
  debug(`Created ${entity.name} delete mutation`)
  return mutation
}
