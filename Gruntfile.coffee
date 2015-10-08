module.exports = (grunt) ->

  # Global vars
  gulp = require 'gulp'
  cssimport = require 'gulp-cssimport'
  paths =
    css: 'src/stylesheets/**/*.*'
    concatFiles: [
      'src/stylesheets/*.*'
    ]
    images: 'assets/*.{png,jpg,gif}'
    assets: 'assets/'
    allAssets: [
      'assets/*.*',
      'config/*',
      'layout/*',
      'locales/*',
      'snippets/*',
      'templates/**/*'
    ]

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # Helper methods
    notify:
      zip:
        options:
          message: 'Zip file created'

    # Shopify theme_gem methods
    exec:
      theme_watch:
        command: 'bundle exec theme watch'
      deploy:
        command: 'bundle exec theme upload'

    # File manipulation
    gulp:
      concat: ->
        return gulp.src(paths.concatFiles)
          .pipe(cssimport())
          .pipe(gulp.dest(paths.assets))

    imagemin:
      dynamic:
        options:
          optimizationLevel: 3
        files: [{
          expand: true
          src: paths.images
        }]

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
          archive: 'hyde.zip'
        files: [
          {src: ['assets/*'], dest: '/', filter: 'isFile'},
          {src: ['config/*'], dest: '/', filter: 'isFile'},
          {src: ['layout/*'], dest: '/', filter: 'isFile'},
          {src: ['snippets/*'], dest: '/', filter: 'isFile'},
          {src: ['templates/*'], dest: '/', filter: 'isFile'}
        ]

    watch:
      css:
        files: paths.css
        tasks: ["sass", "autoprefixer", "gulp"]
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
          "exec"
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
