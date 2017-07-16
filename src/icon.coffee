getIcons = ->
getIcons()
if process.env.NODE_ENV != 'production' and not getIcon?
  console.error "icon-loader wasn't called - please see ceri-icons documentation on how to setup webpack"
  getIcon = (name1,name2)->
    console.error "vue-icons isn't setup properly - failed to get #{name1}-#{name2}"
ceri = require "ceri/lib/wrapper"
module.exports = ceri
  isCeriIcon: true
  mixins: [
    require "ceri/lib/structure"
    require "ceri/lib/svg"
    require "ceri/lib/style"
    require "ceri/lib/props"
    require "ceri/lib/util"
    require "ceri/lib/#show"
  ]

  structure: template 1, """
    <svg version="1.1" 
      :role.expr="@label?'img':'presentation'"
      #show.delay=icon
      :aria-label="label"
      width=0
      height=0
      :width="outerWidth"
      :height="outerHeight" 
      :view-box.camel="box"
      >
      <path :d="icon.d"  :transform="flipped" fill="currentColor"></path>
    </svg>
    <slot></slot>
  """

  props:
    name: String
    size: Number
    scale:
      type: Number
      default: 1
    offsetX:
      type: Number
      default: 0
    offsetY:
      type: Number
      default: 0
    flipH: Boolean
    flipV: Boolean
    label: String
    hcenter: Boolean
  initStyle:
    display: "inline-block"
  computedStyle: this: ->
    if @isStack
      position = "relative"
    else if @stackParent
      position = "absolute"
    else
      position = null
    return {
      height: @outerHeight + "px"
      position: position
      left: if @stackParent then 0 else null
    }
  data: ->
    isStack: false
    stackParent: false
  connectedCallback: ->
    @_stackChildren = []
    for child in @children
      if child.isCeriIcon
        child.stackParent = @
        @_stackChildren.push child
        @isStack = true
      
  computed:
    processedName: ->
      return null unless @name
      tmp = @name.split("-")
      set = tmp.shift()
      return [set,tmp.join("-")]
    icon: ->
      return null unless @processedName
      i = getIcon(@processedName[0],@util.camelize(@processedName[1]))
      return i
    box: ->
      return null unless @heightRatio and @icon
      w = @icon.w
      h = @icon.h
      wOffset = -w * ((@widthRatio - 1) / 2 + @offsetX / 100)
      hOffset = -h * ((@heightRatio - 1) / 2 - @offsetY / 100)
      if @flipV
        s = "-#{w+wOffset} "
      else
        s = "#{wOffset} "
      if @flipH
        s += "-#{h+hOffset} "
      else
        s += "#{hOffset} "
      return s+"#{w*@widthRatio} #{h*@heightRatio}"
    aspect: -> 
      return null unless @icon
      @icon.w / @icon.h
    innerWidth: ->
      @aspect * @innerHeight
    outerWidth:
      master: true
      get: ->
        return @stackParent.outerWidth if @stackParent
        w = @innerWidth
        if @isStack
          for child in @_stackChildren
            cw = child.innerWidth*(1+Math.abs(child.offsetX) / 50)
            w = Math.max(cw, w)
        return w
    widthRatio: -> @outerWidth / @innerWidth
    innerHeight: -> 
      if @size?
        return @size*@scale
      else
        return parseFloat(window.getComputedStyle(@).getPropertyValue("font-size"))*@scale
    outerHeight: 
      master: true
      get: ->
        return @stackParent.outerHeight if @stackParent
        if @hcenter
          return @parentElement.clientHeight
        h = @innerHeight
        if @isStack
          for child in @_stackChildren
            ch = child.innerHeight*(1+Math.abs(child.offsetY) / 50)
            h = Math.max(ch, h)
        return h
    heightRatio: ->
      return @outerHeight / @innerHeight
    flipped: ->
      return null unless @flipH or @flipV
      return "scale(#{-@flipV*2+1},#{-@flipH*2+1})"
