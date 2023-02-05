import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="viewer"
export default class extends Controller {
  static targets = ["container", "toolbar", "infoSection", "commentsSection", "toolbarComments", "toolbarList", "bodyItem", "comments", "pgUp", "pgDown"]
  static values = { active: String }

  connect() {
    addEventListener("scroll", this.watchActivePage);
    addEventListener("scroll", this.watchLoadPage);
    document.documentElement.style.setProperty("--list-body-height",
      window.innerHeight - document.getElementsByClassName("list-body")[0].getBoundingClientRect().top -
     document.getElementsByClassName("toolbar")[0].getBoundingClientRect().height + "px"
     );
  }

  // new page uploaded
  containerTargetConnected(element) {
    if(document.upper_page){
      document.upper_page.realize();
    }
    this.updateNavigation()
  }

  // !Outer function
  watchLoadPage(event) {
    let scrollY = this.scrollY;
    if (scrollY < 1.0 && event.timeStamp > 1000) {
      const prev_pagy = document.getElementById("pagination-prev")
      prev_pagy.setAttribute("src", prev_pagy.getAttribute("lazy_src"))

      document.upper_page = new class Page{
        constructor(){
          this.old_height = $(document).height();
          this.old_scroll = $(window).scrollTop();
          this.flag = true;
        }
        realize(){
          window.scrollTo({
            top: this.old_scroll + $(document).height() - this.old_height,
            left: 0,
            behavior: 'instant',
          })
        }
      }
    }
  }

  // !Outer function
  /**
   * Event handler for scroll, looking for new page in focus, updates #episode-viewer
   * @param {Event} event
   */
  watchActivePage(event) {
    const collection = document.querySelectorAll('[data-viewer-target="container"]');

    let active_page = null;
    collection.forEach((item) => {
      const rect = item.getBoundingClientRect();
      if (rect.bottom >= 0 && rect.top <= (window.innerHeight || document.documentElement.clientHeight)) {
        active_page = item;
      }
    });

    active_page ||= collection[0]
    document.getElementById("episode-viewer").setAttribute("data-viewer-active-value", active_page.getAttribute("for"))
  }

  /**
   * New active page "event"
   * @param {String} value
   * @param {String} previousValue
   */
  activeValueChanged(value, previousValue) {
    if (value != "") {
      this.updateDescription()
      this.updateLike()
      this.setNewLink()
      this.updateActiveItem()
      this.updateComments()
      this.updateNavigation()
    }
  }

  updateNavigation(){
    if(this.containerTargets[0].getAttribute("for"))
    this.pgUpTarget.classList.add("toolbar-item-button--inactive");
    this.pgUpTarget.removeAttribute("href");
  }

  updateActiveItem(){
    // TODO: navigation
    this.bodyItemTargets.forEach(element => {
      if (element.getAttribute("data-for") == this.activeValue){
        element.classList.add("body__item--selected")
      }else{
        element.classList.remove("body__item--selected")
      }
    })
  }

  updateComments(){
    this.commentsTarget.src = "/episode/" + this.activeValue + "/comments"
  }

  updateLike() {
    this.toolbarTarget.querySelector("#likes_turbo_frame").src = "/like/" + this.activeValue + ".turbo_stream"; // /like/9.turbo_stream
  }

  updateDescription() {
    this.toolbarTarget.querySelector("#summary_episode_turbo_frame").src = "/episode/" + this.activeValue + "/summary"
  }

  setNewLink() {
    history.pushState({}, '', "/episode/" + this.activeValue)
  }

  toggleFullScreen(event) {
    event.preventDefault();
    if (!document.fullscreenElement) {
      this.enterFullscreen();
    } else if (document.exitFullscreen) {
      this.exitFullScreen();
      this.openInfo(new Event("none"));
    }
  }

  enterFullscreen() {
    document.documentElement.requestFullscreen();
    this.closeSidebar()
  }

  exitFullScreen() {
    document.exitFullscreen();
  }

  closeSidebar(){
    this.setActiveButtonNone()
    this.commentsSectionTarget.classList.add("sidebar-section--closed")
    this.infoSectionTarget.classList.add("sidebar-section--closed")
  }

  openInfo(event){
    event.preventDefault();
    this.exitFullScreen();
    this.setActiveButtonList();
    this.infoSectionTarget.classList.remove("sidebar-section--closed")
    this.commentsSectionTarget.classList.add("sidebar-section--closed")
  }

  openComments(event){
    event.preventDefault();
    this.exitFullScreen();
    this.setActiveButtonComments();
    this.commentsSectionTarget.classList.remove("sidebar-section--closed")
    this.infoSectionTarget.classList.add("sidebar-section--closed")
  }

  setActiveButtonComments(){
    this.setActiveButtonNone();
    this.toolbarCommentsTarget.classList.add("toolbar-item-button--active");
  }

  setActiveButtonList(){
    this.setActiveButtonNone();
    this.toolbarListTarget.classList.add("toolbar-item-button--active");
  }

  setActiveButtonNone(){
    this.toolbarCommentsTarget.classList.remove("toolbar-item-button--active");
    this.toolbarListTarget.classList.remove("toolbar-item-button--active");
  }
}
