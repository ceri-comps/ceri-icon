# ceri-icon

webpack based - load only what you need - svg inline icons.  
See [ceri-flag](https://github.com/ceri-comps/ceri-flag) if you need a svg inline flag.

Features:
- plain JS - no dependencies
- 21kB unzipped - even smaller when using multiple ceri components

supports:
- [(fa) Font Awesome](https://fortawesome.github.io/Font-Awesome/icons/)
- [(ma) Google Material Design Icons](https://design.google.com/icons/) - spaces in icon names are replaced by `_`, e.g. `material-done_all`.
- [(mdi) Material Design Icons](https://materialdesignicons.com/)
- [(oc) Octicons](https://octicons.github.com/)
- [(ic) Open Iconic](https://useiconic.com/open#icons) 
- [(gly) Glyphicons](http://getbootstrap.com/components/#glyphicons)
- [(im) IcoMoon-free](https://icomoon.io/#preview-free)
- [(ra) ratchicons](http://goratchet.com/components/#ratchicons) - add `and` for android version `ra-download` -> `ra-and-download`
- [(si) Simple Icons](https://simpleicons.org/)

If you need other free icon sets, let me know..

### [Demo](https://ceri-comps.github.io/ceri-icon)

heavily inspired by [vue-awesome](https://github.com/Justineo/vue-awesome).

# Change in 0.2

- ceri-icon is now a webpack plugin instead of a loader.  
See changed (easier) usage instruction below.
- initial optimiziation of icons is way faster on multi-core machines.

# Install

```sh
npm install --save-dev ceri-icon
```

## Usage
- [general ceri component usage instructions](https://github.com/cerijs/ceri#i-want-to-use-a-component-built-with-ceri)


- webpack.config:
```js
// webpack.config.js
Icons = require("ceri-icon")
...
module.exports = {
  ...
  plugins:[
    ...
    new Icons(["fa-heart","gly-heart"])
    ...
  ]
  ...
}
```

- in your project
```coffee
window.customElements.define("ceri-icon", require("ceri-icon"))
```
```html
<ceri-icon name="fa-heart"></ceri-icon>
```

For examples see [`dev/`](dev/).

#### Props
Name | type | default | description
---:| --- | ---| ---
name | String | - | (required) name of the icon
flip-v | String | - | apply vertical flipping
flip-h | String | - | apply horizontal flipping
offset-x | Number | 0 | move the icon left/right within its borders in percentage (relative to the center)
offset-y | Number | 0 | move the icon up/down within its borders in percentage (relative to the center)
label | String | name | aria-label
size | Number | (font-size) | height of the icon in px
scale | Number | 1 | size multiplier
hcenter | Boolean | false | sets the height to equal the parentElement and moves the icon to the center


#### Icon stack
```html
<ceri-icon name="fa-camera">
  <ceri-icon name="fa-ban" style="color:red" scale=2></ceri-icon>
</ceri-icon>
```
`offset-x` and `offset-y` on nested `ceri-icon` increase the size of the icon boundaries, so both will stay fully visible.
The parent `ceri-icon` will be positioned in the center of the, then larger, boundaries.

#### Spinners
`ceri-icon` comes without css, so no spinning included, you can do it manually by adding this css to your website.
```css
/* css */
.spin {
  animation: spin 1s 0s infinite linear;
}
@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
```
```html
<ceri-icon name="fa-spinner" class="spin"></ceri-icon>
```

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
