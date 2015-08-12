var express = require('express');
var router = express.Router();
var passport = require('passport');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Noora Health' });
});

/* GET login */
router.get('/login', function(req, res, next) {
  res.render('login', { title: 'Login'});
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
