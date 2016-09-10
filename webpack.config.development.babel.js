import webpackNotifierPlugin from 'webpack-notifier';
import baseConfig from './webpack.config.base.babel.js';

const config = Object.assign({}, baseConfig);

config.env = 'development';
config.debug = true;
config.devtool = 'inline-source-map';
config.plugins.push(new webpackNotifierPlugin());

export default config;
