import { Controller } from "@hotwired/stimulus"
import { timers } from "jquery"

// Connects to data-controller="viewer"
export default class extends Controller {
  static targets = ["container", "toolbar"]
  static values = {active: String}

  connect() {
    window.scrollTo(0, document.body.scrollHeight);
    addEventListener("scroll", this.clear);
    addEventListener("turbo:before-render", this.stopload)
    this.element.addEventListener("turbo:before-stream-render", this.stopload)
  }

  containerTargetConnected(element){
    element.style.display = "block";
  }

  stopload(event){
    console.log(event);
    event.detail.resume();
  }

  clear(event){
    let active_page = null;
    const collection = document.querySelectorAll('[data-viewer-target="container"]');

    collection.forEach((item) => {
      if(getPositionInVieport(item)){
        active_page = item;
      }
    });

    active_page ||= collection[0]
    document.getElementById("episode-viewer").setAttribute("data-viewer-active-value", active_page.getAttribute("for"))

    if (this.active_page != active_page){
      this.active_page = active_page
    }
  }

  activeValueChanged(){
    if(this.activeValue != ""){
      this.toolbarTarget.querySelector("#likes_turbo_frame").src = "/like/" + this.activeValue + ".turbo_stream"; // /like/9.turbo_stream
      this.toolbarTarget.querySelector("#toolbar-item-description__item").textContent = this.containerTargets.find(item => item.getAttribute("for") == this.activeValue).querySelector(".title").textContent ;
      history.pushState({}, '', "/episode/" + this.activeValue)
    }
  }

  toggleFullScreen(event) {
    event.preventDefault();
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen();
    } else if (document.exitFullscreen) {
      document.exitFullscreen();
    }
  }
}
/**
 *
 * @param {Element} item
 * @returns {boolean} isInViewport
 */
function getPositionInVieport(item){
  const rect = item.getBoundingClientRect();

  const isInViewport = rect.bottom  >= 0 &&
          rect.top <= (window.innerHeight || document.documentElement.clientHeight);
  return isInViewport
}
