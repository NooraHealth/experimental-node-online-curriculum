/*
 * User authentication using Facebook and Google
 */
var passport = require('passport')
var FacebookStrategy = require('passport-facebook').Strategy;
var GoogleStrategy = require('passport-google').Strategy;
var User = require('./models/User.coffee')
var config = require('./oauth.js')
