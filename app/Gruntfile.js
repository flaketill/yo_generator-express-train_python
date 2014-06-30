/*jslint node: true */
"use strict";

//var module = require('moment');

//Detect os 
//var os  = require("os");
//var platform = os.platform();
//var windows = platform.indexOf("win") === 0;
//var linux = platform === "linux";

var LIVERELOAD_PORT = 35729;
var RUNNING_PORT = 3001; // <- if you change this, you need to change in app/config/default.json app/views/partitials/scripts.hbs ap/public/js/socket_test.js
var lrSnippet = require("connect-livereload")({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
  return connect.static(require("path").resolve(dir));
};


module.exports = function (grunt) {
  //We can load all of the tasks automatically with a single line of code, using the matchdep dependency
  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks);

  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json"),
    //validate html
    htmlhint: {
            build: {
                options: {
                    "tag-pair": true,
                    "tagname-lowercase": true,
                    "attr-lowercase": true,
                    "attr-value-double-quotes": true,
                    "doctype-first": true,
                    "spec-char-escape": true,
                    "id-unique": true,
                    "head-script-disabled": true,
                    "style-disabled": true
                },
                src: ["index.html"]
            }
    },
    cssmin: {
      combine: {
        files: {
          "app/public/css/style.css": "app/public/css/style.min.css"
        }
      }
    },
    less: {
      options: {
        //report:'gzip'
      },
      production: {
        options: {
          cleancss: true
        },
        files: {
          "app/public/css/style.css": "app/public/css/less/style.less"
        }
      }
    },
    
    sass: {
      dist: {
        options: {
          style: "compressed"
        },
        files: {
          "app/public/css/style.css": "app/public/css/sass/style.scss",
        }
      }
    },

    stylus: {
      compile: {
        options: {
          compress:true
        },
        files: {
          "app/public/css/style.css": "app/public/css/style-stylus/stylus/style.styl"
        }
      }
    },

    concat: {
      options: 
      {
        separator: ";",
        stripBanners:true
      },
      dist: 
      {
        src: ["app/public/js/app.js"],
        dest: "app/public/js/concat.js",
      },
      foo: 
      {
        files: 
        {
          "dest/a.js": ["src/aa.js", "src/aaa.js"],
          "dest/a1.js": ["src/aa1.js", "src/aaa1.js"]
        }
      },
      bar: 
      {
        files: 
        {
          "dest/b.js": ["src/bb.js", "src/bbb.js"],
          "dest/b1.js": ["src/bb1.js", "src/bbb1.js"]
        }
      }  
    },
    //this is currently turned off, since jquery KILLS it 
    jshint: {
      options: {
        curly: true,
        eqeqeq: false,
        eqnull: true,
        browser: true,
        globals: {
          jQuery: true
        }
      },
      files:{
        src:["app/public/js/concat.js"]
      } 
    },
    // lesslint: {
    //         src: ["less/**/*.less"]
    // },*/
    uglify: { //Lets use UglifyJS to minify this source file
      options: {
        mangle: false,
        banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
      },        
      dist: {
        src: "src/<%= pkg.name %>.js",
        dest: "dist/<%= pkg.name %>.min.js"
      },
      my_target: {
        files: {
          "app/public/js/app.min.js": ["app/public/js/concat.js"]
        }
      },
      dynamic_mappings: 
      {
        // Grunt will search for "**/*.js" under "lib/" when the "uglify" task
        // runs and build the appropriate src-dest file mappings then, so you
        // don't need to update the Gruntfile when files are added or removed.
        files: 
              [
                {
                  expand: true,     // Enable dynamic expansion.
                  cwd: "app/public/js/",      // Src matches are relative to this path.
                  src: ["**/*.js", "!**/slidebars.min.js","!**/jquery.min.js"], // Actual pattern(s) to match.
                  // --> python_sockets_node_io/app/app/public/js/min
                  dest: "app/public/js/min/",   // Destination path prefix.
                  ext: ".min.js",   // Dest filepaths will have this extension.
                  extDot: "first"   // Extensions in filenames begin after the first dot
                  //Paths matching patterns that begin with ! will be excluded from the returned array --> EG: '!docroot/js/main.min.js'
                  // '!**/ie/*'  -- '!**/iecompat.js'
                }
              ]
        }
    },
    // Watch Config
    watch: {      
        files: ["models/**/*","views/**/*","controllers/**/*","public/**/*"],
        options: {
            livereload: true
        },
        html: { //The watch task can run a unique set of tasks according to the file being saved, using targets
          files: ["index.html"],
          tasks: ["htmlhint"]
        },
        scripts: {
            files: [
                "app/public/js/**/*.js"
            ],
            tasks:["build"]
        },
        css: {
            files: [
                "app/public/css/**/*.css",
            ],
        },
        less: {
            files: ["app/app/public/css/less/**/*.less"],
            tasks: ["build"]
        },
        express: {
            files:  [ "server.js", "!**/node_modules/**", "!Gruntfile.js" ],
            tasks:  [ "watch" ],
            options: {
                nospawn: true // Without this option specified express won't be reloaded
            }
        },
    },    
    connect: {
      options: {
        port: RUNNING_PORT,//variable at top of this file
        // change this to '0.0.0.0' to access the server from outside
        hostname: "localhost"
      },
      livereload: {
        options: {
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, ".")
            ];
          }
        }
      }
    },
     nodemon:{
      dev: {
        options: {
          file: "app.js",
          //args: ['dev'],
          //nodeArgs: ['--debug'],
          ignoredFiles: ["node_modules/**"],
          //watchedExtensions: ['js'],
          watchedFolders: ["views", "routes"],
          //delayTime: 1,
          legacyWatch: true,
          env: {
            PORT: RUNNING_PORT
          },
          cwd: __dirname
        }
      }
    },
    reload: {
      port: RUNNING_PORT,
      liveReload: {}
      /*proxy: {
        host: "localhost",
        port: 8080
      }*/
    },
    // run 'watch' indefinitely, together
    concurrent: {
        target: {
            tasks: ["nodemon", "watch","launch"],
            options: {
                logConcurrentOutput: true
            }
        }
    },
    wait:{
      options: {
          delay: 1000
      },
      pause:{
        options:{
          before:function(options){
            console.log("pausing %dms before launching page", options.delay);
          },
          after : function() {
              console.log("pause end, heading to page (using default browser)");
          }
        }
      }
    },
    open: {
      server: {
        path: "http://localhost:" + RUNNING_PORT
      }
    }

  });
 
 
//warning: Recursive process.nextTick detected. This will break in the next version of node. Please use setImmediate for recursive deferral.
//else use grunt --force
//echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

//In my case solved with:

//http://stackoverflow.com/questions/16748737/grunt-watch-error-waiting-fatal-error-watch-enospc  
//Arch Linux add fs.inotify.max_user_watches=524288 to /etc/sysctl.d/99-sysctl.conf and then execute sysctl --system. 

//This is not ne
//Without matchdep, we would have to write: 
  // grunt.loadNpmTasks("grunt-contrib-jshint");
  // grunt.loadNpmTasks("grunt-lesslint");
  // grunt.registerTask("default", ["jshint"]);
  
  // grunt.registerTask("lesslint", ["lesslint"]);

  //grunt.loadNpmTasks("grunt-contrib-watch");
  //grunt.loadNpmTasks("grunt-reload");

  //grunt.registerTask("styles", [ "sass"]); //TO evit warning: Recursive process.nextTick detected. This will break in the next version of node. Please use setImmediate for recursive deferral.

//task.registerTask('default', ['jshint', 'qunit', 'concat', 'uglify']);
  grunt.registerTask("default", ["build", "concurrent"]);
  grunt.registerTask("build", ["cssmin", "concat", "uglify"]);
  grunt.registerTask("launch", ["wait", "open"]);


};
