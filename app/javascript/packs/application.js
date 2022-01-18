// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
var jQuery = require("jquery")
//require("jquery.turbolinks")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "channels"
import "custom"
//import "custom/modals"
//import "popperjs/core"
import "bootstrap" // imports the bootstrap javascript module
// Import the specific modules you may need (Modal, Alert, etc)
//import { Tooltip, Popover } from "bootstrap"

import "../stylesheets/application"
import "@nathanvda/cocoon"

require("trix")
require("@rails/actiontext")
import "controllers"


// include jQuery in global and window scope (so you can access it globally)
// in your web browser, when you type $('.div'), it is actually refering to global.$('.div')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;
