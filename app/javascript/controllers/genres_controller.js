import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="genres"
export default class extends Controller {
  static targets = ["tag", "selector"]

  connect() {
  }

  /**
   * @param {Event} event The second number to add.
   */
  update(event){
    if (this.element.querySelectorAll('input[type="checkbox"]:checked').length == 4){
      event.target.checked = false;
      return;
    }

    if(this.element.querySelectorAll('input[type="checkbox"]:checked').length == 0){
      const empty = document.createElement("option")
      empty.value = "-1"
      empty.textContent = "None"
      empty.selected = true;
      this.selectorTarget.replaceChildren(empty);
    }else{
      if(event.target.checked){
        const node = document.createElement("option")
        node.value = event.target.getAttribute("genre_id")
        node.textContent = event.target.value
        if (this.selectorTarget.children[0].value == "-1"){
          node.selected = true;
          this.selectorTarget.replaceChildren(node);
        }else{
          node.selected = false;
          this.selectorTarget.appendChild(node);
        }
      }else{
        this.selectorTarget.querySelector("[value='" + event.target.getAttribute("genre_id") + "']").remove()
      }
    }
  }
}
