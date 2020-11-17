import Debug from 'debug'
import { S3, config } from 'aws-sdk'
import type { ICreateArgs, IQueryArgs, IRemoveArgs, IUpdateArgs, DataConnector, IDataConnector } from '../types/connector'
import type { IFilter } from '../middleware/utils/filter'
import { createReadStream } from 'fs'
import path from 'path'

const debug = Debug('funfunz:S3DataConnector')

type S3Config = {
  bucket: string
  region?: string,
  apiVersion?: string,
}

export class Connector implements DataConnector{
  public connection: S3
  private config: S3Config
  constructor(connector: IDataConnector<S3Config>) {
    this.config = connector.config
    config.update({region: this.config.region || 'us-west-2'})
    this.connection = new S3({apiVersion: this.config.apiVersion || '2006-03-01'})

    debug('Start')
    Object.keys(connector).forEach(
      (key) => {
        debug(key, (connector)[key])
      }
    )
    debug('End')
  }

  public query(args: IQueryArgs): Promise<Record<string, unknown>[]> {
    let keyFilter: {key: string, filter: string} | undefined = undefined
    if (args.filter) {
      keyFilter = this.getKeyFromFilter(args.filter) || undefined
    }

    console.log(keyFilter)

    return new Promise<S3.ObjectList>(
      (res, rej) => {
        this.connection.listObjectsV2(
          {
            Bucket: this.config.bucket,
            Prefix: keyFilter?.key
          },
          (err, data) => {
            if (err) {
              console.log('err', err)
              return rej(err)
            }
            res(data.Contents || [])
          }
        )
      }
    ).then(
      (data: S3.ObjectList) => {
        let result: Record<string, unknown>[] = data as unknown as Record<string, unknown>[]
        if (keyFilter?.filter === '_eq') {
          result = result.filter(
            (entry) => entry.Key === keyFilter?.key
          )
        }
        return result
      }
    )
  }

  public update(args: IUpdateArgs): Promise<Record<string, unknown>[] | Record<string, unknown> | number> {
    console.log(args)
    return Promise.resolve([])
  }

  public create(args: ICreateArgs): Promise<Record<string, unknown>[] | Record<string, unknown>> {
    console.log(args)
    const file = 'fileName.txt'

    // Configure the file stream and obtain the upload parameters
    
    const fileStream = createReadStream(file)
    fileStream.on('error', function(err) {
      console.log('File Error', err)
    })
    const Body = fileStream
    
    const Key = path.basename(file)

    const uploadParams = {Bucket: this.config.bucket, Key, Body}

    // call S3 to retrieve upload file to specified bucket
    return new Promise(
      (res, rej) => {
        this.connection.upload(
          uploadParams,
          (err, data) => {
            if (err) {
              return rej(err)
            }
            if (data) {
              res(data)
            }
          }
        )
      }
    )
  }

  public remove(args: IRemoveArgs): Promise<number> {
    console.log(args)
    return Promise.resolve(0)
  }

  private getKeyFromFilter(filter: IFilter): {key: string, filter: string} | undefined {
    let result: {key: string, filter: string} | undefined = undefined
    Object.keys(filter).some(
      (filterKey) => {
        if (filterKey === 'Key') {
          const entry = filter[filterKey] as Record<string, string>
          if (entry._like !== undefined) {
            result = {
              key: entry._like,
              filter: '_like'
            }
          }
          if (entry._eq !== undefined) {
            result = {
              key: entry._eq,
              filter: '_eq'
            }
          }
        }
        if (filterKey === '_and' || filterKey === '_or') {
          const value = (filter[filterKey] as IFilter['_and'] | IFilter['_or']) || []
        
          value.forEach(
            (entry) => {
              const innerResult = this.getKeyFromFilter(entry)
              if (innerResult) {
                result = innerResult
              }
            }
          )
        }
        return !!result
      }
    )
    return result
  }
}