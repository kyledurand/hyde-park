module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    sass:
      options:
        style: "compressed"
        sourcemap: "none"

      dist:
        files:
          "assets/theme.css": "assets/stylesheets/theme.scss"

    browserify:
      dist:
        files: "assets/theme.js": "assets/javascripts/theme.coffee"
        options:
          transform: ["coffeeify"]

    cssmin:
      dist:
        files:
          "assets/theme.css": ["assets/theme.css"]

    autoprefixer:
      options:
        browsers: [
          "last 2 versions"
          "ie 8"
          "ie 9"
        ]

      dist:
        src: "assets/theme.css"
        dest: "assets/theme.css"

    shell:
      theme_watch:
        command: "theme watch"

      theme_replace:
        command: "theme replace"

    compress:
      main:
        options:
          archive: 'Sello.zip'
        files: [
          {src: ['assets/*'], dest: '/', filter: 'isFile'},
          {src: ['config/*'], dest: '/', filter: 'isFile'},
          {src: ['layout/*'], dest: '/', filter: 'isFile'},
          {src: ['snippets/*'], dest: '/', filter: 'isFile'},
          {src: ['templates/*'], dest: '/', filter: 'isFile'}
        ]

    watch:
      css:
        files: "assets/stylesheets/**/*.scss"
        tasks: ["sass", "autoprefixer"]
        options:
          spawn: false

      coffee:
        files: "assets/javascripts/**/*.coffee"
        tasks: ["browserify"]
        options:
          spawn: false

    concurrent:
      default:
        tasks: [
          "watch"
          "shell:theme_watch"
        ]
        options:
          logConcurrentOutput: true

  require("load-grunt-tasks")(grunt)

  grunt.registerTask "default", [
    "sass"
    "autoprefixer"
    "browserify"
    "concurrent:default"
  ]

  grunt.registerTask "deploy", [
    "sass"
    "browserify"
    "autoprefixer"
    "cssmin"
    "shell:theme_replace"
  ]

  grunt.registerTask "build", [
    "sass"
    "browserify"
    "autoprefixer"
    "cssmin"
    "compress"
  ]
