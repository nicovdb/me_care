import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['range', 'value', 'hidden']

  updateValue(e) {
    this.hiddenTarget.value = e.currentTarget.value;
  }
}
