import webpack from 'webpack';
import path from 'path';

import postcssAutoprefixer from 'autoprefixer';
import postcssCamelCase from 'postcss-camel-case';
import postcssNested from 'postcss-nested';
import postcssLocal from 'postcss-modules-local-by-default';

export default {
  entry: [
    'babel-polyfill',
    path.join(__dirname, 'src', 'scripts', 'App.js')
  ],
  output: {
    path: path.join(__dirname, 'dist', 'assets', 'scripts'),
    filename: 'main.js'
  },
  module: {
    preLoaders: [
      {
        test: /\.tag$/,
        loader: 'riotjs-loader',
        exclude: /node_modules/
      },
      {
        test: /\.(js|tag)$/,
        exclude: /node_modules/,
        loader: 'eslint-loader'
      }
    ],
    loaders: [
      {
        test: /\.(js|tag)$/,
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        loader: 'style!css!postcss',
        exclude: /node_modules/
      },
      {
        test: /\.json$/,
        loader: 'json-loader',
        exclude: /node_modules/
      },
    ]
  },
  postcss: () => ({
    defaults: [
      postcssAutoprefixer,
      postcssCamelCase,
      postcssNested,
      postcssLocal
    ]
  }),
  resolve: {
    extensions: ['', '.js', '.tag']
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    }),
    new webpack.optimize.OccurenceOrderPlugin()
  ],
  progress: true,
  cache: true
};
