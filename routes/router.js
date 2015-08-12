var express = require('express');
var router = express.Router();
var passport = require('passport');
var User = require('../models/User.coffee');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Noora Health' });
});

/* GET login */
router.get('/login', function(req, res, next) {
  res.render('login', { title: 'Login'});
});

/* POST login */
/*
router.post('/login', passport.authenticate('local'), function(req, res) {
  res.redirect('/');
});
*/
router.post('/login', passport.authenticate('local'), function(req, res) {
    console.log(req.user.email);
    console.log(" is logged in");
    res.redirect('/');
  });

/* GET register */
router.get('/register', function(req, res, next) {
  res.render('register', { title: 'Register'});
});

/* POST register*/
router.post('/register', function(req, res, next) {
  console.log('registering user, email is ' + req.body.email + ' password is ' + req.body.password);
  User.register(new User({ email : req.body.email, password: req.body.password, created : Date.now()}), req.body.password, function(err) {
    if (err) {
      console.log('error while registering user', err);
      return next(err);
    }
    console.log('user registered');
    res.redirect('/');
  });
});

/* GET logout */
router.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

// test authentication
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/');
}

/* GET account page */
/*router.get('/account', ensureAuthenticated, function(req, res){
  res.render('account', { user: user});
  User.findById(req.session.passport.user, function(err, user) {
    if(err) { 
      console.log(err); 
    } else {
      res.render('account', { user: user});
    }
  })
})*/


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
