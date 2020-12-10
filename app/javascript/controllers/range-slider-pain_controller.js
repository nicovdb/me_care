import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['range', 'value', 'hidden']

  connect() {
    if (this.hasValueTarget) {
      this.valueTarget.innerHTML = this.rangeTarget.value
    }
  }

  updateValue(evt) {
    this.valueTarget.innerHTML = evt.currentTarget.value;
    this.hiddenTarget.value = evt.currentTarget.value;
  }
}
