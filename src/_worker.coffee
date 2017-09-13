fs = require "fs-extra"
svgfont2js = require "svgfont2js"
SVGO = require "svgo"
svgo = new SVGO(multipass: true)
path = require "path"
svgpath = require "svgpath"
iconPath = require "./icon-path"

loadAliases = (less,re) =>
  m = {}
  match = undefined
  
  while null != (match = re.exec(less))
    alias = match[1]
    unicode_hex = match[2]
    m[unicode_hex] = [] unless m[unicode_hex]?
    m[unicode_hex].push(alias)
  return m



module.exports = (sets) => Promise.all sets.map (set) =>
  #console.log "processing icon set: " + set.name
  re = /d="([\w\s-.]*)"/
  optimizers = []
  if set.svg
    if set.re
      set.re = new RegExp(set.re,"g")
      aliases = loadAliases(fs.readFileSync(require.resolve(set.style), "utf8"),set.re)
    glyphs = svgfont2js(fs.readFileSync(require.resolve(set.svg), "utf8"))
    for glyph in glyphs
      optimizers.push new Promise (resolve) =>
        d = new svgpath(glyph.path)
        if set.translateY
          d = d.translate(0, set.translateY)
        d = d.rel().toString()
        svgo.optimize "<svg width='#{glyph.width}' height='#{glyph.height}'><path d='#{d}'/></svg>", (result) =>
          match = re.exec(result.data)
          if match?[1]
            glyph.path = match[1]
            resolve glyph
          else
            #console.log "#{set.name}: #{glyph.name} failed to match"
            resolve null
  else if set.folder
    for f in ["node_modules/#{set.folder}","../#{set.folder}"]
      folder = path.resolve(f)
      try
        stat = await fs.lstat(folder)
        break if stat.isDirectory()
      folder = null
    if folder
      processFile = (file, name) =>
        fs.readFile file, encoding:"utf8"
        .then (content) => new Promise (resolve, reject) =>
          try
            svgo.optimize content, (result) =>
              d  = re.exec(result.data)
              box = /viewBox="0 0 ([0-9]+) ([0-9]+)"/.exec(result.data)
              if d? and d.length > 1 and box? and box.length > 2
                resolve {
                  name: name
                  path: d[1]
                  width: box[1]
                  height: box[2]
                }
              else
                #console.log "#{set.short}: #{name} failed to match"
                resolve null
          catch e
            console.error "svgo failed for file: #{file}"
            console.error e 
            resolve()
        .catch (e) =>
          console.error "file: #{file}"
          console.error e 
      files = await fs.readdir(folder)
      tmpre = new RegExp(set.re,"i")
      for file in files
        optimizers.push(processFile(path.resolve(folder,file),name[1])) if (name = tmpre.exec(file))?


  Promise.all(optimizers)
  .then (glyphs) ->
    data = {aliases:{},icons:{}}
    for glyph in glyphs
      if glyph?
        if set.svg and set.re
          tmp = glyph['unicode_hex']
          if tmp.length == 2
            tmp = "00"+tmp
          else if tmp.length == 3
            tmp = "0"+tmp
          names = aliases[tmp]
        else
          names = [glyph.name]
        if names?
          name = names.shift()
          icon =
            d: glyph.path
            w: glyph.width
            h: glyph.height
          if names.length > 0
            for alias in names
              data.aliases[alias] = name
            icon.aliases = names
          data.icons[name] = icon
    console.log "#{set.short} (#{set.name}): #{glyphs.length} glyphs, #{Object.keys(data.icons).length} icons, #{Object.keys(data.aliases).length} aliases"
    return data
  .then JSON.stringify
  .then fs.writeFile.bind(null, path.resolve(iconPath,"#{set.short}.json"))
  
