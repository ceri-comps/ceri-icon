
path = require "path"
fs = require "fs-extra"
ext = path.extname(__filename)
if ext == ".coffee"
  require "coffeescript/register"
iconPath = require "./icon-path"
VirtualModulePlugin = require('virtual-module-webpack-plugin')

allIcons = {}
for file in fs.readdirSync(iconPath)
  allIcons[path.basename(file,".json")] = require path.resolve(iconPath, file)

module.exports = class Icons
  constructor: (options) ->
    result = {}
    for name in options
      tmp = name.split("-")
      set = tmp.shift()
      tmp = tmp.join("-")
      iconset = allIcons[set]
      iname = tmp unless (iname = iconset.aliases[tmp])?
      if (icon = iconset.icons[iname])?
        iconName = set+"-"+iname
        result[iconName] = icon
        if icon.aliases?
          for alias in icon.aliases
            result[set+"-"+alias] = iconName
          delete icon.aliases
      else
        throw new Error "ceri-icon: icon '#{name}' not found"

    return new VirtualModulePlugin
      path: path.resolve(__dirname,"_ceri-icon.json")
      contents: JSON.stringify(result)