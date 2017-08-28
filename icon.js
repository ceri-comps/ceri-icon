(function() {
  var ceri, icons;

  icons = require("./_ceri-icon.json");

  ceri = require("ceri/lib/wrapper");

  module.exports = ceri({
    isCeriIcon: true,
    mixins: [require("ceri/lib/structure"), require("ceri/lib/svg"), require("ceri/lib/style"), require("ceri/lib/props"), require("ceri/lib/#show")],
    structure: function(){return [this.el("svg",{"version":{"":"1.1"},"role":{":":function(){return this.label?'img':'presentation';}},"show":{"#":{"val":"icon","mods":{"delay":true}}},"aria-label":{":":"label"},"width":{"":"0",":":"outerWidth"},"height":{"":"0",":":"outerHeight"},"view-box":{":":{"val":"box","mods":{"camel":true}}}},[this.el("path",{"d":{":":"icon.d"},"transform":{":":"flipped"},"fill":{"":"currentColor"}},[])]),"default"]}











,
    props: {
      name: String,
      size: Number,
      scale: {
        type: Number,
        "default": 1
      },
      offsetX: {
        type: Number,
        "default": 0
      },
      offsetY: {
        type: Number,
        "default": 0
      },
      flipH: Boolean,
      flipV: Boolean,
      label: String,
      hcenter: Boolean
    },
    initStyle: {
      display: "inline-block"
    },
    computedStyle: {
      "this": function() {
        var position;
        if (this.isStack) {
          position = "relative";
        } else if (this.stackParent) {
          position = "absolute";
        } else {
          position = null;
        }
        return {
          height: this.outerHeight + "px",
          width: this.outerWidth + "px",
          position: position,
          left: this.stackParent ? 0 : null
        };
      }
    },
    data: function() {
      return {
        isStack: false,
        stackParent: false
      };
    },
    connectedCallback: function() {
      var child, j, len, ref, results;
      this._stackChildren = [];
      ref = this.children;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        child = ref[j];
        if (child.isCeriIcon) {
          child.stackParent = this;
          this._stackChildren.push(child);
          results.push(this.isStack = true);
        } else {
          results.push(void 0);
        }
      }
      return results;
    },
    computed: {
      icon: function() {
        var i;
        i = icons[this.name];
        if (typeof i === "string" || i instanceof String) {
          i = icons[i];
        }
        if (process.env.NODE_ENV !== 'production' && (this.name != null) && (i == null)) {
          console.log(icons);
          console.error("ceri-icon isn't setup properly - failed to get " + this.name);
        }
        return i;
      },
      box: function() {
        var h, hOffset, s, w, wOffset;
        if (!(this.heightRatio && this.icon)) {
          return null;
        }
        w = this.icon.w;
        h = this.icon.h;
        wOffset = -w * ((this.widthRatio - 1) / 2 + this.offsetX / 100);
        hOffset = -h * ((this.heightRatio - 1) / 2 - this.offsetY / 100);
        if (this.flipV) {
          s = "-" + (w + wOffset) + " ";
        } else {
          s = wOffset + " ";
        }
        if (this.flipH) {
          s += "-" + (h + hOffset) + " ";
        } else {
          s += hOffset + " ";
        }
        return s + ((w * this.widthRatio) + " " + (h * this.heightRatio));
      },
      aspect: function() {
        if (!this.icon) {
          return null;
        }
        return this.icon.w / this.icon.h;
      },
      innerWidth: function() {
        return this.aspect * this.innerHeight;
      },
      outerWidth: {
        master: true,
        get: function() {
          var child, cw, j, len, ref, w;
          if (this.stackParent) {
            return this.stackParent.outerWidth;
          }
          w = this.innerWidth;
          if (this.isStack) {
            ref = this._stackChildren;
            for (j = 0, len = ref.length; j < len; j++) {
              child = ref[j];
              cw = child.innerWidth * (1 + Math.abs(child.offsetX) / 50);
              w = Math.max(cw, w);
            }
          }
          return w;
        }
      },
      widthRatio: function() {
        return this.outerWidth / this.innerWidth;
      },
      innerHeight: function() {
        if (this.size != null) {
          return this.size * this.scale;
        } else {
          return parseFloat(window.getComputedStyle(this).getPropertyValue("font-size")) * this.scale;
        }
      },
      outerHeight: {
        master: true,
        get: function() {
          var ch, child, h, j, len, ref;
          if (this.stackParent) {
            return this.stackParent.outerHeight;
          }
          if (this.hcenter) {
            return this.parentElement.clientHeight;
          }
          h = this.innerHeight;
          if (this.isStack) {
            ref = this._stackChildren;
            for (j = 0, len = ref.length; j < len; j++) {
              child = ref[j];
              ch = child.innerHeight * (1 + Math.abs(child.offsetY) / 50);
              h = Math.max(ch, h);
            }
          }
          return h;
        }
      },
      heightRatio: function() {
        return this.outerHeight / this.innerHeight;
      },
      flipped: function() {
        if (!(this.flipH || this.flipV)) {
          return null;
        }
        return "scale(" + (-this.flipV * 2 + 1) + "," + (-this.flipH * 2 + 1) + ")";
      }
    }
  });

}).call(this);
