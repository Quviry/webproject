import { Turbo } from "@hotwired/turbo-rails";

Turbo.setConfirmMethod((message, element) => {
    let dialog = document.getElementById("turbo-confirm");
    let message_p = dialog.querySelector("#turbo-confirm-message")
    message_p.innerHTML = message || message_p.innerHTML;
    dialog.showModal();

    return new Promise((resolve, reject) => {
        dialog.addEventListener("close", () => {
            resolve(dialog.returnValue == "confirm")
        }, {once: true})
    })
})

