var ids = {
  facebook: {
    clientID: process.env.FACEBOOK_CLIENT_ID,
    clientSecret: process.env.FACEBOOK_CLIENT_SECRET,
    callbackURL: process.env.HOST + '/auth/facebook/callback/'
  },
  
  /*google: {
    returnURL: process.env.HOST + '/auth/google/callback',
    realm: process.env.HOST
  }*/
  google: {
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: process.env.HOST + '/auth/google/callback/'
  }
}

module.exports = ids
