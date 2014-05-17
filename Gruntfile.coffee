module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeeify'
  grunt.initConfig
    coffeeify:
      files:
        src:['src/**/*.coffee']
        dest:'dist/explorer.js'

    phantom:
      options:
        port: 4444

    connect:
      app:
        options:
          port: 3000
          base: '.'

  grunt.registerTask "build", ["coffeeify"]
  grunt.registerTask "explore", 'exploring googleplay', () ->
    Explorer = require('./src/explorer')
    explorer = new Explorer
    explorer.start()
    explorer.execute()
