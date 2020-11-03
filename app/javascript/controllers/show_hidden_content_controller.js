import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "hiddenContent", "button" ]

  showOrHideContent() {
    this.hiddenContentTarget.classList.toggle("d-none")
    this.buttonTarget.classList.toggle("arrow-bottom")
    this.buttonTarget.classList.toggle("arrow-top")
  }
}
