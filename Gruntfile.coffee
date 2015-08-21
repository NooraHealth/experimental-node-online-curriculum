module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    loadPath: require('node-bourbon').includePaths

    env:
      dev:
        src: '.env/dev.json'

      prod:
        src: '.env/production.json'

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

  grunt.registerTask 'default', ['sass', 'browserify', 'env:dev', 'nodemon']
  grunt.registerTask 'production', ['env:prod', 'nodemon']
  grunt.registerTask 'build:dev', ['env:dev']
  grunt.registerTask 'build:prod', ['env:prod']
