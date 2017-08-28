path = require "path"
if path.extname(__filename) == ".coffee"
  try
    require "coffeescript/register"
  catch
    try
      require "coffee-script/register"
iconsPath = "../icons"
module.exports = path.resolve(__dirname, iconsPath)