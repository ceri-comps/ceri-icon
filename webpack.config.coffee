path = require "path"
module.exports =
  module:
    rules: [{ 
        test: /ceri-icon(\/src)?\/icon/
        enforce: "post"
        loader: path.resolve(__dirname,"src/icon-loader.coffee")
        options:
          icons: [
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
    }]
