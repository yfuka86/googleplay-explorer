module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeeify'
  grunt.initConfig
    coffeeify:
      options:
      files:
        src:['src/**/*.coffee']
        dest:'dist/explorer.js'

    connect:
      app:
        options:
          port: 3098
          base: '.'

  grunt.registerTask "build", ["coffeeify"]