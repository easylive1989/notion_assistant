var path = require('path')

module.exports = {
  entry: ['./main.js'],
  output: {
    path: path.join(__dirname, '../web'),
    filename: '../web/background.js'
  }
}