
window.toastr = require("toastr")

// sutup toastr.js
toastr.options = {
    "closeButton": true,
    "debug": true,
    "newestOnTop": false,
    "progressBar": true,
    "positionClass": "toast-bottom-right",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

window.addEventListener("load", () => {
    // flash => info, error, warning, notice
    // toastr => warning, success, error, info
    const analogs = {
        "info": "success",
        "warning": "warning",
        "error": "error",
        "notice": "info"
    };
    [].slice.call($("flash")).forEach((element) => {
        toastr[analogs[element.getAttribute("method")]](element.textContent);
    })
})

addEventListener("turbo:before-stream-render", ((event) => {
    const fallbackToDefaultActions = event.detail.render

    event.detail.render = function (streamElement) {
        if (streamElement.action == "flash") {
            const analogs = {
                "info": "success",
                "warning": "warning",
                "error": "error",
                "notice": "info"
            };
            toastr[analogs[streamElement.getAttribute("method")]](streamElement.templateContent);
        } else {
            fallbackToDefaultActions(streamElement)
        }
    }
})
)
