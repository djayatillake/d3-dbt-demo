cube(`Example`, {
  sql: `SELECT * FROM ${process.env.DB_SCHEMA}.example_model`,

  joins: {},

  measures: {
    count: {
      type: `count`
    },
    
    createdAt: {
      type: `time`,
      sql: `created_at`
    }
  },

  dimensions: {
    id: {
      sql: `id`,
      type: `number`,
      primaryKey: true
    },

    name: {
      sql: `name`,
      type: `string`
    }
  }
});
