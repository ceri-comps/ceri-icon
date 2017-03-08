path = require "path"
if path.extname(__filename) == ".coffee"
  iconsPath = "../icons"
else
  iconsPath = "./icons"
module.exports = path.resolve(__dirname, iconsPath)