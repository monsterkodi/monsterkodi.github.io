
# https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/
#
# gem install bundler
# bundle install     
# bundle update github-pages
# grunt
#

module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        salt:
            style: 
                options:
                    verbose     : false
                    textMarker  : '//!'
                    textPrefix  : '/*'
                    textFill    : '*  '
                    textPostfix : '*/'
                files:
                    'asciiText' : ['style/*.styl']

        stylus:
            options:
                compress: false
            compile:
                files:
                    'css/style.css':  ['style/style.styl']

        watch:
            sources:
                files: ['style/*.styl', '_layouts/*.html', '_includes/*.html', '*.md']
                tasks: ['build']

        clean: ['style/*.css', '_site']
                            
        shell:
            options:
                execOptions: 
                    maxBuffer: Infinity
            test: 
                command: "open _site/index.html"
            jekyll:
                command: "bundle exec jekyll build"
                
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-bower-concat'
    grunt.loadNpmTasks 'grunt-pepper'
    grunt.loadNpmTasks 'grunt-shell'

    grunt.registerTask 'build',     [ 'clean', 'stylus', 'salt', 'shell:jekyll', 'shell:test' ]
    grunt.registerTask 'default',   [ 'build' ]
