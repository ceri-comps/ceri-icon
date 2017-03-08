# out: ../icon-loader.js
path = require "path"
fs = require "fs"
loaderUtils = require "loader-utils"
ext = path.extname(__filename)
if ext == ".coffee"
  require "coffee-script/register"
iconPath = require "./icon-path"
camelize = (str) -> str.replace /-(\w)/g, (_, c) -> if c then c.toUpperCase() else ''

convertToText = (obj) ->
  string = []
  if obj == undefined
    return String(obj)
  else if (Array.isArray and Array.isArray(obj)) or
      Object.prototype.toString.call(obj) == '[object Array]'
    for prop in obj
      string.push(convertToText(obj[prop]))
    return "[" + string.join(",") + "]"
  else if typeof(obj) == "function"
    string.push(obj.toString())

  else if typeof(obj) == "object" and obj?
    for key,val of obj
      string.push(key + ": " + convertToText(val))
    return "{" + string.join(",") + "}"
  else
    string.push(JSON.stringify(obj))
  return string.join(",")


allIcons = {}
for file in fs.readdirSync(iconPath)
  allIcons[path.basename(file,".json")] = require path.resolve(iconPath, file)
module.exports = (source, map) ->
    options = loaderUtils.getOptions(@)
    sets = {}
    for iconname in options.icons
      tmp = iconname.split("-")
      coll = tmp.shift()
      name = tmp.join("-")
      throw new Error "ceri-icons: collection not found: #{coll}" unless allIcons[coll]
      if allIcons[coll].aliases[name]
        name = allIcons[coll].aliases[name]
      icon = allIcons[coll].icons[name]
      throw new Error "ceri-icons: #{name} not found in icon collection: #{coll}" unless icon
      sets[coll] = {a:{},i:{}} unless sets[coll]
      cName = camelize(name)
      unless sets[coll].i[cName]?
        sets[coll].i[cName] = d:icon.d, w:icon.w, h:icon.h
        if icon.aliases?
          for alias in icon.aliases
            sets[coll].a[camelize(alias)] = cName
    getIcon = """
    var sets = #{convertToText(sets)}

    function getIcon(coll, name) {
      set = sets[coll]
      if (process.env.NODE_ENV !== 'production' && (typeof set === "undefined" || set === null)){
        console.warn("ceri-icons - icon collection "+coll+" not found, is your webpack set up correctly?")
      }
      if (set.a[name] != null) {
        name = set.a[name]
      }
      var icon = set.i[name]
      if (process.env.NODE_ENV !== 'production' && (typeof icon === "undefined" || icon === null)) {
        console.warn("cerivue-icons - icon "+coll+"-"+name+" not found, is your webpack set up correctly?")
      }
      return icon
    }
    """
    @cacheable?()
    cb = @async?() || @callback
    cb(null,source.replace(/getIcons\(\);/g,getIcon),map)
    return 
