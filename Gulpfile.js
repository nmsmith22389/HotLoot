const gulp = require('gulp');
const sass = require('gulp-sass');
const pug = require('gulp-pug');
const sourcemaps = require('gulp-sourcemaps');
const autoprefixer = require('gulp-autoprefixer');
const browserSync = require('browser-sync');
const babel = require('gulp-babel');
const gutil = require('gulp-util');
const ngrok = require('ngrok');

const autoprefixerOptions = {
    browsers: ['last 2 versions', 'ie >= 9', 'and_chr >= 2.3']
  };

const sassOptions = {
    errLogToConsole: true,
    outputStyle: 'expanded'
};

gulp.task('styles', function() {
    gulp.src('src/sass/**/*.scss')
        .pipe(sourcemaps.init())
        .pipe(sass().on('error', sass.logError))
        .pipe(sourcemaps.write())
        .pipe(autoprefixer(autoprefixerOptions))
        .pipe(gulp.dest('./css/'))
        .pipe(browserSync.stream())
});

gulp.task('html', function() {
    return gulp.src('src/pug/*.pug')
        .pipe(pug({
        // Your options in here. 
    }))
    .pipe(gulp.dest('./'))
});

gulp.task('reload', function (done) {
    browserSync.reload();
    return gutil.log('BrowserSync Reload...');
});

const reload = browserSync.reload;

gulp.task('pug-watch', ['html'], reload);

gulp.task('javascript', function () {
    return gulp.src('src/js/app.js')
        .pipe(babel({
            "presets": [
              ["env", {
                "targets": {
                  "browsers": ['last 2 versions', 'ie >= 9', 'and_chr >= 2.3']
                }
              }]
            ]
          }))
        .pipe(gulp.dest('js'));
});

//Watch task
gulp.task('default', ['html','styles'], function() {
    browserSync.init({
        server: {
            baseDir: "./"
        },
        open: false
    });
    
    gulp.watch('src/sass/**/*.scss',['styles']);
    gulp.watch('src/pug/**/*.pug',['pug-watch']);
});

//Watch task
gulp.task('ngrok', ['html','styles'], function() {
    browserSync.init({
		server: {
            baseDir: "./"
        },
        open: false
	}, function(err, bs) {
		ngrok.connect(bs.options.get('port'), function(err, url) {
			console.log(' -------------------------------------');
			gutil.log('\r', '      NGROK:', gutil.colors.magenta(url));
			console.log(' -------------------------------------');
		});
	});
    
    gulp.watch('src/sass/**/*.scss',['styles']);
    gulp.watch('src/pug/**/*.pug',['pug-watch']);
});