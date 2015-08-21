module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    loadPath: require('node-bourbon').includePaths

    env:
      dev:
        src: '.env/dev.json'

      prod:
        src: '.env/production.json'

    compress:

    phonegap:
      dev:
        options:
          archive: "app.zip"
          appId: process.env.PHONEGAP_APP_ID
          user:
            email: process.env.PHONEGAP_EMAIL
            password: process.env.PHONEGAP_PASSWORD

      prod:
        options:
          appId: process.env.PHONEGAP_APP_ID
          user:
            token: process.env.PHONEGAP_TOKEN

    sass:
      options:
        includePaths: require('node-bourbon').includePaths
      dist:
        files:
          'build/stylesheets/style.css':'public/stylesheets/scss/style.scss'

    clean: ['build/**/*']

    browserify:
      dist:
        files:
          'build/module.js':['public/**/*.coffee']
          'build/register.js':['public/coffee/views/register.coffee']
        options:
          transform: ['coffeeify']
          watch: true
          #keepAlive: true
          watchifyOptions:
            outFile: 'build/module.js'
            verbose:true

    nodemon:
      nodeArgs: ['--debug']
      dev:
        script: 'bin/www'

        callback: (nodemon) ->
          nodemon.on 'log', (event) ->
            console.log event.color
    
  )

  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-watchify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-phonegap'
  grunt.loadNpmTasks 'grunt-contrib-compress'

  grunt.registerTask "phonegap-dev", ['env:dev', 'compress', 'phonegap:dev']
  grunt.registerTask "phonegap-prod", ['env:prod', 'compress', 'phonegap:prod']
  grunt.registerTask 'default', ['sass', 'browserify', 'env:dev', 'nodemon']
  grunt.registerTask 'production', ['env:prod', 'nodemon']
  grunt.registerTask 'build:dev', ['env:dev']
  grunt.registerTask 'build:prod', ['env:prod']
