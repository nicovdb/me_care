import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['range', 'value', 'hidden']

  updateValue(evt) {
    this.hiddenTarget.value = evt.currentTarget.value;
  }
}
