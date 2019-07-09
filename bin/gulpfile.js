var gulp     = require('gulp');
var changed  = require('gulp-changed');
var watch = require("gulp-watch");
var plumber = require("gulp-plumber");

var srcDir = [
  '/go/src/github.com/qmu-jp/frnc-backend-src/src/revel/**/**',
  '!/go/src/github.com/qmu-jp/frnc-backend-src/src/revel/vendor/**/**'
];
var dstDir = '/go/src/github.com/qmu-jp/frnc-backend/src/revel/';

gulp.task("watch", function () {
  watch(srcDir, function(event){
    gulp.start("copy");
  });
});
gulp.task("copy", function () {
  return gulp.src(srcDir)
    .pipe(plumber({
      errorHandler: function(err) {
        console.log(err.messageFormatted);
        this.emit('end');
      }
    }))
    .pipe(changed(dstDir))
    .pipe(gulp.dest(dstDir));
});
gulp.task('default', ['watch']);
