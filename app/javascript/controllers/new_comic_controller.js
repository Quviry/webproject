import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "char_counter", "url" ]

  connect(){
    this.char_counterTarget.innerText = "0"
  }

  renamed(event){
    if(event.target.value.length > 100){
      event.target.value = event.target.value.slice(0, 100);
    }
    this.char_counterTarget.innerText = event.target.value.length;
    this.urlTarget.value = event.target.value.replace(/[^A-Za-z ]/gm, '').replace(/ /gm, "-")
  }

  genered(event){
    if (event.keyCode == 13){
      event.preventDefault()
      const data = event.target.value;
      event.target.value = ""
      let input = "<input type=\"checkbox\" name=\"" + event.target.for +  "[tags_list][]\" id=\"tag-"+ data + "\" value=\""+ data + "\" class=\"btn-check\" autocomplete=\"off\" data-action=\"new-comic#remove\"></input>"
      input += "<label class=\"btn btn-outline-primary\" for=\"tag-"+ data + "\">"+ data + "</label>"
      document.getElementById("genres-bar").innerHTML += input
    }
  }

  remove(event){
    event.target.nextElementSibling.remove();
    event.target.remove();
  }
}


