// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// 
// it's worth learning about the ~ character when using imports as it will start a lookup from the node_modules 

require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")
require("konva")

// ./node_modules/@fortawesome/fontawesome-free/js/fontawesome.js
// require("@fortawesome/fontawesome-free")

import 'bootstrap';
import HoldsPinner from 'climbing-holds-pinner.js';

window.HoldsPinner = HoldsPinner;
window.$ = $;

import '../../stylesheets/application.scss';

// https://rossta.net/blog/from-sprockets-to-webpack.html
