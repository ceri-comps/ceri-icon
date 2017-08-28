path = require "path"
Icons = require "./src/icon-plugin.coffee"
module.exports =
  devtool: false
  plugins:[
    new Icons [
      "fa-glass"
      "fa-cab"
      "fa-bullhorn"
      "fa-camera"
      "fa-ban"
      "mdi-account-alert"
      "ma-build"
      "oc-logo-github"
      "oc-heart"
      "ic-wrench"
      "gly-heart"
      "fa-thumbs-up"
      "fa-beer"
      "im-IcoMoon"
      "ra-download"
      "ra-and-download"
      ]
  ]
