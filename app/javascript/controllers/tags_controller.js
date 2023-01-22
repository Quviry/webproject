import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tags"
export default class extends Controller {
  static targets = ["tag", "selector"]

  connect() {
  }

  /**
   * @param {Event} event The second number to add.
   */
  update(event){
    if (event.code == "Enter"){
      event.preventDefault();
      if (document.getElementById("tags-bar").querySelector("[value='"+ event.target.value +"']")){
        return false;
      }
      const data = event.target.value;
      event.target.value = ""
      let input = "<input type=\"checkbox\" name=\"" + event.target.getAttribute("for") +  "[tags_list][]\" id=\"tag-"+ data + "\" value=\""+ data + "\" class=\"btn-check\" autocomplete=\"off\" data-action=\"tags#remove\" checked></input>"
      input += "<label class=\"btn btn-outline-primary m-1\" for=\"tag-"+ data + "\">"+ data + "</label>"
      document.getElementById("tags-bar").innerHTML += input
    }else if(event.code == "Space"){
      event.preventDefault()
    }
  }

  remove(event){
    event.target.nextElementSibling.remove();
    event.target.remove();
  }
}
