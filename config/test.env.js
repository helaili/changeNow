var merge = require('webpack-merge')
var devEnv = require('./dev.env')

module.exports = merge(devEnv, {
  NODE_ENV: '"testing"',
  db: {
    connectionLimit: 10,
    acquireTimeout: 10000,
    host: '127.0.0.1',
    port: 3360,
    user: 'gh-ost',
    password: 'gh-ost',
    database: 'gh-ost'
  }
})
