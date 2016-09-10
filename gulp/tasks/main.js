import gulp from 'gulp';
import gutil from 'gulp-util';
import store from '../store.js';
import del from 'del';

gulp.task('default', () => {
  gutil.log(gutil.colors.green('`gulp`'), gutil.colors.magenta('command is not allowed. Use'), gutil.colors.green('`npm start`'), gutil.colors.magenta('instead'));
});

gulp.task('dev', () => {
  declareTask('Running as development mode.');
  store.setDevelopment();
  store.setWatching();

  gulp.start([
    'static',
    'server',
    'js'
  ]);
});

gulp.task('prod', () => {
  declareTask('Building production files.');
  store.setProduction();

  del('dist').then(() => {
    gulp.start([
      'static',
      'js'
    ]);
  });
});

function declareTask(message) {
  gutil.log(gutil.colors.bgCyan.bold(message));
}
