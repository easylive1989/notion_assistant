var path = require('path')

module.exports = {
  entry: ['./main.js'],
  output: {
    path: path.join(__dirname, ''),
    filename: 'background.js'
  }
}