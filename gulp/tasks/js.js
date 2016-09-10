import gulp from 'gulp';
import gulpLoadPlugins from 'gulp-load-plugins';
import webpack from 'webpack';
import store from '../store.js';
import browserSync from 'browser-sync';

import webpackConfigDevelopment from '../../webpack.config.development.babel.js';
import webpackConfigProduction from '../../webpack.config.production.babel.js';

const $ = gulpLoadPlugins();

gulp.task('js', () => {
  rebundle(false);

  if (store.isWatching()) {
    $.watch('src/scripts/**/*', rebundle);
  }
});

function rebundle(_firedByWatch) {
  const firedByWatch = typeof _firedByWatch === 'boolean' ? _firedByWatch : true;

  webpack((store.isDevelopment() ? webpackConfigDevelopment : webpackConfigProduction), (err, stats) => {
    if (err) {
      throw new $.util.PluginError('webpack', err);
    }

    store.isWatching() && firedByWatch && browserSync.reload();

    const jsonStats = stats.toJson();
    if (jsonStats.errors.length) {
      jsonStats.errors.forEach(error => $.util.log($.util.colors.bgRed('webpack:error'), $.util.colors.magenta(error)));
      return;
    }
    if (jsonStats.warnings.length) {
      jsonStats.warnings.forEach(warning => $.util.log($.util.colors.bgRed('webpack:warning'), $.util.colors.magenta(warning)));
      return;
    }

    $.util.log('webpack', stats.toString({
      hash: false,
      version: false,
      chunks: false,
      reasons: true,
      colors: true
    }));
  });
}
