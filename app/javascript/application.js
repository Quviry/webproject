// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap"
import './add_jquery'
import "jquery-ui"
import "jqtree"
import * as datepicker from "jquery-datetimepicker"
import("jquery-ui");
import("jqtree");
import "./custom_confirm"

let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
})

import * as ActiveStorage from "activestorage"
ActiveStorage.start()


// If you are using JavaScript/ECMAScript modules:
import Dropzone from "dropzone";


// If you are using an older version than Dropzone 6.0.0,
// then you need to disabled the autoDiscover behaviour here:
Dropzone.autoDiscover = false;

// let myDropzone = new Dropzone("#my-form");
// myDropzone.on("addedfile", file => {
//   console.log(`File added: ${file.name}`);
// });

import "./controllers"

// actiontext
import "trix"
import "@rails/actiontext"

