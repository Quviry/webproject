import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

import "bootstrap"

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
  $('.toast').toast({ autohide: false })
  $('#toast').toast('show')
})

global.toastr = require("toastr")
