###
# User Model
###
mongoose = require('mongoose')
Schema = mongoose.Schema
passportLocalMongoose = require 'passport-local-mongoose'

userSchema = {
  oauthID: Number,
  name: String,
  created: Date,
  email: String,
}

UserSchema = new Schema userSchema

options = {
  usernameField: 'email',
}

UserSchema.plugin passportLocalMongoose, options

User = mongoose.model 'app-user' , UserSchema

module.exports = User
###
User = mongoose.model 'app-user', {
  oauthID: Number,
  name: String,
  created: Date
}

module.exports = User
###
