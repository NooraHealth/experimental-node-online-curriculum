###
# User Model
###
mongoose = require('mongoose')

User = mongoose.model 'app-user', {
  oauthID: Number,
  name: String,
  created: Date
}

module.export = User
