import { IHookProps } from '../../../types/hooks'

export default {
  name: 'families',
  connector: 'mainDatabase',
  visible: true,
  relations: [
    {
      type: '1:n',
      foreignKey: 'FamilyId',
      remoteTable: 'products'
    }
  ],
  properties: [
    {
      name: 'id',
      filterable: true,
      model: {
        type: 'number',
        allowNull: false,
        isPk: true
      },
      layout: {
        label: 'Id',
        entityPage: {
          searchable: true,
        },
        editField: {
          type: 'number'
        }
      }
    },
    {
      name: 'order',
      filterable: true,
      visible: {
        list: true,
        detail: true,
        relation: false
      },
      model: {
        type: 'number',
        allowNull: true
      },
      layout: {
        label: 'Order',
        listColumn: {},
        editField: {
          type: 'number'
        }
      }
    },
    {
      name: 'imageUrl',
      filterable: true,
      model: {
        type: 'string',
        allowNull: true
      },
      'layout': {
        'label': 'ImageUrl',
        'listColumn': {},
        'editField': {
          type: 'text'
        }
      }
    },
    {
      'name': 'name',
      'filterable': true,
      'visible': {
        'list': true,
        'detail': true,
        'relation': false,
      },
      model: {
        type: 'string',
        allowNull: false
      },
      layout: {
        label: 'Name',
        listColumn: {},
        editField: {
          type: 'text'
        }
      }
    },
    {
      name: 'email',
      filterable: true,
      visible: {
        list: true,
        detail: true,
        relation: false
      },
      model: {
        type: 'string',
        allowNull: true
      },
      layout: {
        label: 'Email',
        listColumn: {},
        editField: {
          type: 'text'
        }
      }
    },
    {
      name: 'createdAt',
      filterable: true,
      visible: {
        list: true,
        detail: false,
        relation: false
      },
      model: {
        type: 'string',
        allowNull: false
      },
      layout: {
        label: 'CreatedAt',
        listColumn: {},
        editField: {
          type: 'date'
        }
      }
    },
    {
      name: 'updatedAt',
      filterable: true,
      visible: {
        list: true,
        detail: false,
        relation: false
      },
      model: {
        type: 'string',
        allowNull: false
      },
      layout: {
        label: 'UpdatedAt',
        listColumn: {},
        editField: {
          type: 'date'
        }
      }
    }
  ],
  hooks: {
    count: {
      async afterQueryResult(props: IHookProps<unknown, unknown>) {
        props.results = 69
        return props
      }
    }
  },
  layout: {
    label: 'Families',
    listPage: {},
    searchField: {},
    createButton: {},
    editButton: {},
    deleteButton: {},
    editPage: {
      sections: []
    }
  }
}