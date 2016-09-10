import gulp from 'gulp';
import browserSync from 'browser-sync';

gulp.task('server', () => {
  browserSync({
    port: 8901,
    open: false,
    ghostMode: false,
    reloadOnRestart: true,
    notify: false,
    server: {
      baseDir: 'dist',
      directory: false
    }
  });
});
