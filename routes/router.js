var express = require('express');
var router = express.Router();
var passport = require('passport');
var User = require('../models/User.coffee');

// test authentication
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/login');
}

/* GET home page. */
router.get('/', ensureAuthenticated, function(req, res, next) {
  res.render('index', { title: 'Noora Health' });
});

/* GET login */
router.get('/login', function(req, res, next) {
  if (req.user) {
    console.log("You are already logged in");
  } else {
    res.render('login', { title: 'Login'});
  }
});

/* POST login */
router.post('/login', passport.authenticate('local'), function(req, res) {
    res.redirect('/');
  });

/* GET register */
router.get('/register', function(req, res, next) {
  res.render('register', { title: 'Register'});
});

/* POST register*/
router.post('/register', function(req, res, next) {
  User.register(new User({ email : req.body.email, password: req.body.password, created : Date.now()}), req.body.password, function(err) {
    if (err) {
      console.log('error while registering user', err);
      return next(err);
    }
    passport.authenticate('local')(req, res, function() {
      res.redirect('/');
    });
  });
});

/* GET logout */
router.get('/logout', function(req, res){
  if (req.user) {
    console.log(req.user.email + " is logging out");
    req.logout();
  } else {
    console.log("nobody is logged in");
  }
  res.redirect('/');
});

/* GET Facebook authentication */
router.get('/auth/facebook',
  passport.authenticate('facebook'),
  function(req, res){
  });
router.get('/auth/facebook/callback/', 
  passport.authenticate('facebook', { failureRedirect: '/login' }),
  function(req, res) {
    res.redirect('/');
  });

/* GET Google authentication */
router.get('/auth/google',
  passport.authenticate('google', { scope: ['https://www.googleapis.com/auth/plus.login']}),
  function(req, res){
  });
router.get('/auth/google/callback', 
  passport.authenticate('google', { failureRedirect: '/login' }),
  function(req, res) {
    res.redirect('/');
  });

module.exports = router;
