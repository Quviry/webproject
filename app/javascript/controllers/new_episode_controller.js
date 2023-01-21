import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-episode"
export default class extends Controller {
  static targets = [ "datetime" ]

  connect() {
    this.datetimeTarget.datetimepicker({startDate: new Date()}).on('changeDate', function(){
      this.datetimeTarget.datetimepicker('setStartDate', new Date());
    })
  }

  convict(){
    alert("heyo")
  }
}
