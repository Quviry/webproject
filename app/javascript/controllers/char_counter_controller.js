import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-counter"
export default class extends Controller {
  static targets = ["counter", "total"]
  static values = { limit: Number }

  connect() {
    console.log(this.limitValue)

    this.totalTarget.textContent = "/" + this.limitValue;
    this.counterTarget.textContent = this.element.getElementsByTagName("input")[0].value.length;
  }

  /**
   * @param {Event} event The second number to add.
   */
  update(event){
    if (event.target.value.length >= this.limitValue){
      event.target.value = event.target.value.substr(0, this.limitValue);
    }
    this.counterTarget.textContent = event.target.value.trim().length;
  }
}
