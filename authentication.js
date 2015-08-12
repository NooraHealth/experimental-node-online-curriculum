/*
 * User authentication using Facebook and Google
 */
var passport = require('passport')
var FacebookStrategy = require('passport-facebook').Strategy;
var GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;
var User = require('./models/User.coffee')
var config = require('./oauth.js')
var LocalStrategy = require('passport-local').Strategy;

module.exports = passport.use(new FacebookStrategy({
  clientID: config.facebook.clientID,
  clientSecret: config.facebook.clientSecret,
  callbackURL: config.facebook.callbackURL
},
function(accessToken, refreshToken, profile, done) {
  console.log("accessToken is: " + accessToken);
  console.log("refreshToken is: " + refreshToken);
  console.log("profile is: " + profile);
  console.log("done is: " + done);
  User.findOne({ oauthID: profile.id }, function(err, user) {
    if (err) {
      console.log("error while finding user: " + err);
    }
    if (!err && user != null) {
      console.log("user exists");
      done(null, user);
    } else {
      console.log("user does not exist");
      var user = new User({
        oauthID: profile.id,
        name: profile.displayName,
        created: Date.now()
      });
      console.log("about to save user" + user);
      user.save(function(err) {
        if(err) {
          console.log("error while saving user: ");
          console.log(err);
        } else {
          console.log("saving user ...");
          done(null, user);
        };
      });
    };
  });
}));
  
passport.use(new GoogleStrategy({
  clientID: config.google.clientID,
  clientSecret: config.google.clientSecret,
  callbackURL: config.google.callbackURL
},
function(accessToken, refreshToken, profile, done) {
  console.log("accessToken is: " + accessToken);
  console.log("refreshToken is: " + refreshToken);
  console.log("profile is: ");
  console.log(profile);
  console.log("done is: " + done);

  User.findOne({ oauthID: profile.id }, function(err, user) {
    if (err) {
      console.log("error while finding user: " + err);
    }
    if (!err && user != null) {
      console.log("user exists");
      done(null, user);
    } else {
      console.log("user does not exist");
      var user = new User({
        oauthID: profile.id,
        name: profile.displayName,
        created: Date.now()
      });
      console.log("about to save user" + user);
      user.save(function(err) {
        if(err) {
          console.log("error while saving user: ");
          console.log(err);
        } else {
          console.log("saving user ...");
          done(null, user);
        };
      });
    };
  });
}));

passport.use(User.createStrategy());
