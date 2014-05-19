module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeeify'
  grunt.initConfig
    coffee:
      compile:
        files:
          './explorer.js': ['src/explorer.coffee']

    coffeeify:
      files:
        src:['src/**/*.coffee']
        dest:'dist/explorer.js'

    connect:
      app:
        options:
          port: 3000
          base: '.'

  grunt.registerTask "build", ["coffee"]
