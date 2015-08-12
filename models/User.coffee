###
# User Model
###
mongoose = require('mongoose')
###
Schema = mongoose.Schema

userSchema = 
  oauthID: Number,
  name: String,
  created: Date
}

UserSchema = new Schema userSchema

User = mongoose.model 'app-user' , UserSchema

module.exports = User
###
User = mongoose.model 'app-user', {
  oauthID: Number,
  name: String,
  created: Date
}

module.exports = User
