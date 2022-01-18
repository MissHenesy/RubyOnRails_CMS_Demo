const { environment } = require('@rails/webpacker')
const webpack = require("webpack");

// Add an additional plugin of your choosing : ProvidePlugin
// NOTE: 2021-12-28 SLH -- This was added via::
// https://rubyyagi.com/how-to-use-bootstrap-and-jquery-in-rails-6-with-webpacker/
/*environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)*/

environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"] // for Bootstrap 4
  })
);

module.exports = environment
