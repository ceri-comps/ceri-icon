window.customElements.define "ce-icon", require "../src/icon.coffee"
ceri = require "ceri-dev-server/lib/createView"
module.exports = ceri
  structure: template 1,"""
    <a href="https://github.com/ceri-comps/ceri-icon/blob/master/dev/basic.coffee">source</a>
    <p>fa-glass:
      <ce-icon name="fa-glass" #ref="fa"></ce-icon>
    </p>
    <p>fa-taxi:
      <ce-icon name="fa-taxi"></ce-icon>
    </p>
    <p>fa-cab (alias):
      <ce-icon name="fa-cab"></ce-icon>
    </p>
    <p>fa-taxi (flip-h):
      <ce-icon name="fa-taxi" flip-h="flip-h" #ref="horizontal"></ce-icon>
    </p>
    <p>fa-bullhorn:
      <ce-icon name="fa-bullhorn"></ce-icon>
    </p>
    <p>fa-bullhorn (flip-v):
      <ce-icon name="fa-bullhorn" flip-v="flip-v" #ref="vertical"></ce-icon>
    </p>
    <p>fa-bullhorn (size=32):
      <ce-icon name="fa-bullhorn" size="32" #ref="size"></ce-icon>
    </p>
    <p>fa-bullhorn (scale=2):
      <ce-icon name="fa-bullhorn" scale="2" #ref="scale"></ce-icon>
    </p>
    <p>mdi-account-alert:
      <ce-icon name="mdi-account-alert" #ref="mdi"></ce-icon>
    </p>
    <p>mdi-account-alert (style="color:red"):
      <ce-icon style="color: red;" name="mdi-account-alert" #ref="color"></ce-icon>
    </p>
    <p>ma-build:
      <ce-icon name="ma-build" #ref="material"></ce-icon>
    </p>
    <p>ma-build(flip-h and flip-v):
      <ce-icon name="ma-build" flip-h="flip-h" flip-v="flip-v" #ref="flipboth"></ce-icon>
    </p>
    <p>oc-logo-github:
      <ce-icon name="oc-logo-github" #ref="octicon"></ce-icon>
    </p>
    <p>oc-heart:
      <ce-icon name="oc-heart"></ce-icon>
    </p>
    <p>gly-heart:
      <ce-icon name="gly-heart" #ref="glyphicon"></ce-icon>
    </p>
    <p>im-IcoMoon:
      <ce-icon name="im-IcoMoon" #ref="im"></ce-icon>
    </p>
    <p>ra-download:
      <ce-icon name="ra-download" #ref="ra"></ce-icon>
    </p>
    <p>ra-and-download:
      <ce-icon name="ra-and-download"></ce-icon>
    </p>
    <p>ic-wrench:
      <ce-icon name="ic-wrench" #ref="iconic"></ce-icon>
      <span>(vertical-align:sub):</span>
      <ce-icon name="ic-wrench" style="vertical-align:sub;"></ce-icon>
    </p>
    <p style="height:40px;border: 1px solid black;">ic-wrench (height:40px without hcenter):
      <ce-icon name="ic-wrench"></ce-icon>
    </p>
    <p style="height:40px;border: 1px solid black; position:relative;">ic-wrench (height:40px with hcenter), don't use hcenter with text
      <ce-icon name="ic-wrench" hcenter #ref="hcenter"></ce-icon>
    </p>
    <p style="line-height:40px;border: 1px solid black; position:relative;">ic-wrench (line-height:40px)
      <ce-icon name="ic-wrench"></ce-icon>
    </p>
    <p>gly-heart(offset-x=-20, offset-y=20):
      <ce-icon name="gly-heart" #ref="offset" offset-x="-20" offset-y="20"></ce-icon>
    </p>
    <p>fa-ban(scale=2,style="color:red") on fa-camera:
      <ce-icon name="fa-camera">
        <ce-icon name="fa-ban" style="color:red;" scale="2"></ce-icon>
      </ce-icon>
    </p>
    <p>fa-beer on fa-thumbs-up (with offset-x / offset-y and scale):
      <ce-icon name="fa-thumbs-up" offset-x="-30">
        <ce-icon name="fa-beer" offset-x="30" scale="1.2" offset-y="-20"></ce-icon>
      </ce-icon>
    </p>
  """
  connectedCallback: ->
    @style.fontSize = "12pt"
  tests: (el) ->
    describe "icon", ->
      before (done) -> setTimeout done,250
      after ->
        el.remove()
      it "should font awesome", ->
        icon = el.fa.firstChild
        icon.should.have.attr "viewBox", "0 0 1792 1792"
        icon.firstChild.should.have.attr "d","M1699 186q0 35-43 78l-632 632v768h320q26 0 45 19t19 45-19 45-45 19H448q-26 0-45-19t-19-45 19-45 45-19h320V896L136 264q-43-43-43-78 0-23 18-36.5t38-17.5 43-4h1408q23 0 43 4t38 17.5 18 36.5z"

      it "should material design icons", ->
        icon = el.mdi.firstChild
        icon.should.have.attr "viewBox", "0 0 512 512"
        icon.firstChild.should.have.attr "d","M213.3 85.3c47.2 0 85.4 38.2 85.4 85.4S260.5 256 213.3 256 128 217.8 128 170.7s38.2-85.4 85.3-85.4m0 213.4c94.3 0 170.7 38.2 170.7 85.3v42.7H42.7V384c0-47.1 76.3-85.3 170.6-85.3M426.7 256V149.3h42.6V256h-42.6m0 85.3v-42.6h42.6v42.6h-42.6z"

      it "should google material icons", ->
        icon = el.material.firstChild
        icon.should.have.attr "viewBox", "0 0 512 512"
        icon.firstChild.should.have.attr "d","M484 405c9 6 9 21-2 30l-49 49c-9 9-21 9-30 0L209 290c-49 19-106 9-147-32-43-43-54-107-28-158l94 92 64-64-92-92c51-23 115-15 158 28 41 41 51 98 32 147z"

      it "should octicons", ->
        icon = el.octicon.firstChild
        icon.should.have.attr "viewBox", "0 0 45 16"
        icon.firstChild.should.have.attr "d","M18.53 12.03h-.02c.009 0 .015.01.024.011h.006l-.01-.01zm.004.011c-.093.001-.327.05-.574.05-.78 0-1.05-.36-1.05-.83V8.13h1.59c.09 0 .16-.08.16-.19v-1.7c0-.09-.08-.17-.16-.17h-1.59V3.96c0-.08-.05-.13-.14-.13h-2.16c-.09 0-.14.05-.14.13v2.17s-1.09.27-1.16.28c-.08.02-.13.09-.13.17v1.36c0 .11.08.19.17.19h1.11v3.28c0 2.44 1.7 2.69 2.86 2.69.53 0 1.17-.17 1.27-.22.06-.02.09-.09.09-.16v-1.5a.177.177 0 0 0-.146-.18zm23.696-2.2c0-1.81-.73-2.05-1.5-1.97-.6.04-1.08.34-1.08.34v3.52s.49.34 1.22.36c1.03.03 1.36-.34 1.36-2.25zm2.43-.16c0 3.43-1.11 4.41-3.05 4.41-1.64 0-2.52-.83-2.52-.83s-.04.46-.09.52c-.03.06-.08.08-.14.08h-1.48c-.1 0-.19-.08-.19-.17l.02-11.11c0-.09.08-.17.17-.17h2.13c.09 0 .17.08.17.17v3.77s.82-.53 2.02-.53l-.01-.02c1.2 0 2.97.45 2.97 3.88zm-8.72-3.61h-2.1c-.11 0-.17.08-.17.19v5.44s-.55.39-1.3.39-.97-.34-.97-1.09V6.25c0-.09-.08-.17-.17-.17h-2.14c-.09 0-.17.08-.17.17v5.11c0 2.2 1.23 2.75 2.92 2.75 1.39 0 2.52-.77 2.52-.77s.05.39.08.45c.02.05.09.09.16.09h1.34c.11 0 .17-.08.17-.17l.02-7.47c0-.09-.08-.17-.19-.17zm-23.7-.01h-2.13c-.09 0-.17.09-.17.2v7.34c0 .2.13.27.3.27h1.92c.2 0 .25-.09.25-.27V6.23c0-.09-.08-.17-.17-.17zm-1.05-3.38c-.77 0-1.38.61-1.38 1.38 0 .77.61 1.38 1.38 1.38.75 0 1.36-.61 1.36-1.38 0-.77-.61-1.38-1.36-1.38zm16.49-.25h-2.11c-.09 0-.17.08-.17.17v4.09h-3.31V2.6c0-.09-.08-.17-.17-.17h-2.13c-.09 0-.17.08-.17.17v11.11c0 .09.09.17.17.17h2.13c.09 0 .17-.08.17-.17V8.96h3.31l-.02 4.75c0 .09.08.17.17.17h2.13c.09 0 .17-.08.17-.17V2.6c0-.09-.08-.17-.17-.17zM8.81 7.35v5.74c0 .04-.01.11-.06.13 0 0-1.25.89-3.31.89-2.49 0-5.44-.78-5.44-5.92S2.58 1.99 5.1 2c2.18 0 3.06.49 3.2.58.04.05.06.09.06.14L7.94 4.5c0 .09-.09.2-.2.17-.36-.11-.9-.33-2.17-.33-1.47 0-3.05.42-3.05 3.73s1.5 3.7 2.58 3.7c.92 0 1.25-.11 1.25-.11v-2.3H4.88c-.11 0-.19-.08-.19-.17V7.35c0-.09.08-.17.19-.17h3.74c.11 0 .19.08.19.17z"

      it "should iconic", ->
        icon = el.iconic.firstChild
        icon.should.have.attr "viewBox", "0 0 900 800"
        icon.firstChild.should.have.attr "d","M551 0c16 0 32 0 47 3l-97 97v200h200l97-97c3 15 3 31 3 47 0 138-112 250-250 250-32 0-62-8-90-19L173 772c-20 20-46 28-72 28s-52-8-72-28c-39-39-39-105 0-144l291-287c-11-28-19-59-19-91C301 112 413 0 551 0zM101 650c-28 0-50 22-50 50s22 50 50 50 50-22 50-50-22-50-50-50z"

      it "should glyphicon", ->
        icon = el.glyphicon.firstChild
        icon.should.have.attr "viewBox", "0 0 1200 1200"
        icon.firstChild.should.have.attr "d","M649 251q48-68 109.5-104T880 108.5t118.5 20 102.5 64 71 100.5 27 123q0 57-33.5 117.5t-94 124.5T945 785.5 795 938t-146 174q-62-85-145.5-174t-150-152.5T227 658t-93.5-124.5T100 416q0-64 28-123t73-100.5 104-64 119-20T544.5 147 649 251z"

      it "should icomoon", ->
        icon = el.im.firstChild
        icon.should.have.attr "viewBox", "0 0 16 16"
        icon.firstChild.should.have.attr "d","M4.055 8a1.851 1.851 0 1 1 3.703 0 1.851 1.851 0 0 1-3.703 0zM8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zM5.928 14.989C3.522 13.589 1.905 10.984 1.905 8s1.617-5.589 4.023-6.989C8.334 2.41 9.953 5.016 9.953 8s-1.618 5.589-4.025 6.989z"

      it "should flip horizontal", ->
        icon = el.horizontal.firstChild
        icon.should.have.attr "viewBox", "0 -1792 2048 1792"
        icon.firstChild.should.have.attr "transform","scale(1,-1)"

      it "should flip vertical", ->
        icon = el.vertical.firstChild
        icon.should.have.attr "viewBox", "-1792 0 1792 1792"
        icon.firstChild.should.have.attr "transform","scale(-1,1)"

      it "should flip both", ->
        icon = el.flipboth.firstChild
        icon.should.have.attr "viewBox", "-512 -512 512 512"
        icon.firstChild.should.have.attr "transform","scale(-1,-1)"
      it "should size", ->
        icon = el.size.firstChild
        icon.should.have.attr "height", "32"

      it "should scale", ->
        icon = el.scale.firstChild
        icon.should.have.attr "height", "32"

      it "should color", ->
        icon = el.color
        icon.should.have.attr("style").match(/color: red/)

      it "should hcenter", ->
        icon = el.hcenter
        box = icon.getBoundingClientRect()
        box.height.should.equal 40
        box = icon.firstChild.getBoundingClientRect()
        box.height.should.equal 40