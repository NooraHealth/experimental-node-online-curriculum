var fs = require('fs');
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var coffee = require('coffee-script').register();
var config = require('./oauth.js');
var passport = require('passport');
var session = require('express-session');

//connect to MongoDB
mongoose.connect(process.env.MONGO_URL);

//MODELS
var User = require('./models/User.coffee');
// prints out all users in the database 
User.find({}, function(err, users) {
  var userMap = {};
  users.forEach(function(user) {
    userMap[user._id] = user;
  });
  console.log("All users in database: ");
  console.log(userMap);
});

//AUTHENTICATION
var auth = require('./authentication.js')

//ROUTER
var routes = require('./routes/router.js');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(session({ 
  resave: true,
  saveUninitialized: true,
  secret: "Noora Health users",
  maxAge: 6000
}));
app.use(express.static(path.join(__dirname, 'public')));
app.use(passport.initialize());
app.use(passport.session());

// seralize and deseralize
passport.serializeUser(function(user, done) {
    console.log('serializeUser: ' + user._id)
    done(null, user._id);
});
passport.deserializeUser(function(id, done) {
    User.findById(id, function(err, user){
        console.log(user);
        if(!err) done(null, user);
        else done(err, null);
    })
});

//Routes
app.use('/', routes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
