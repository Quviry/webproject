import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-loader"
export default class extends Controller {
  connect() {
    console.log("Image loader connected");
  }

  update(event){
    const file = event.target.files[0]
    const img = this.element.getElementsByTagName("img")[0];
    img.src = URL.createObjectURL(file)
  }

}
