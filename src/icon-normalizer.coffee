fs = require "fs-extra"
path = require "path"
iconPath = require "./icon-path"
handleThat = require "handle-that"
ora = require "ora"

sets = [{
    short: "fa"
    name: "font-aweseome"
    re: "@fa-var-([a-z0-9-]+)\\s*:\\s*\"\\\\([0-9a-f]+)\";"
    style: "font-awesome/less/variables.less"
    svg: "font-awesome/fonts/fontawesome-webfont.svg"
  },{
    short: "gly"
    name: "glyphicons"
    re: "glyphicon-([^\\s]*)[^\\n]*content: \"\\\\([^\"]*)"
    style: "bootstrap/less/glyphicons.less"
    svg: "bootstrap/fonts/glyphicons-halflings-regular.svg"
    translateY: 240
  },{
    short: "mdi"
    name: "mdi material design icons"
    svg: "mdi/fonts/materialdesignicons-webfont.svg"
  },{
    short: "oc"
    name: "octicons"
    folder: "octicons/build/svg"
    re: "([A-Za-z0-9-]+).svg"
  },{
    short: "ma"
    name: "google material design icons"
    svg: "material-design-icons/iconfont/MaterialIcons-Regular.svg"
  },{
    short: "ic"
    name: "open iconic"
    svg: "open-iconic/font/fonts/open-iconic.svg"
    style: "open-iconic/font/css/open-iconic.css"
    re: "\\.oi\\[data-glyph=([^\\]]+)\\]:before { content:'\\\\([^']+)'; }"
  },{
    short: "im"
    name: "icomoon-free"
    folder: "icomoon-free-npm/SVG"
    re: "[0-9]+-([A-Za-z0-9-]+).svg"
  },{
    short: "ra"
    name: "ratchet"
    svg: "ratchet/fonts/ratchicons.svg"
  },{
    short: "si"
    name: "simple-icons"
    folder: "simple-icons/icons"
    re: "([A-Za-z0-9-]+).svg"
  }]
console.log "\nNormalizing and optimizing SVG Icons for ceri-icon"

fs.ensureDir(iconPath)

spinner = ora(sets.length + " icon sets remaining...").start()

handleThat sets,
  worker: path.resolve(iconPath, "../lib", "_worker")
  onText: (lines, remaining) =>
    spinner.stop()
    console.log(lines.join("\n"))
    spinner.start(remaining + " icon sets remaining...")
  onProgress: (remaining) => spinner.text = remaining + " icon sets remaining..."
  onFinish: => spinner.succeed "all icon sets normalized and optimized"

