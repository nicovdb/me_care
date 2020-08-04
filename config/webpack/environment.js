const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const erb = require('./loaders/erb')
const path = require('path');
const webpack = require('webpack');
// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: path.resolve(path.join(__dirname, '../../node_modules', 'jquery')),
    Popper: ['popper.js', 'default']
  })
);
environment.loaders.prepend('erb', erb)
environment.loaders.prepend('coffee', coffee)
module.exports = environment
