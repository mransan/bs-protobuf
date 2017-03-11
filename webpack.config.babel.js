import path from 'path';

export default {
  entry: [
    './src/client',
  ],
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist/js'),
  },
  module: {
    rules: [
      { test: /\.(js|jsx)$/, use: 'babel-loader', exclude: /node_modules/ },
    ],
  },
  devtool: 'source-map',
  resolve: { extensions: ['.js', '.jsx'], },
}
