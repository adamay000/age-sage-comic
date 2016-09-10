import webpack from 'webpack';
import baseConfig from './webpack.config.base.babel.js';

const config = Object.assign({}, baseConfig);

config.env = 'production';
config.plugins.push(new webpack.optimize.UglifyJsPlugin({ compress: { warnings: false } }));

export default config;
