import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['range', 'value', 'hidden']

  connect() {
    if (this.hasValueTarget) {
      this.updateText(this.rangeTarget.value)
    }
  }

  updateValue(e) {
    this.updateText(e.currentTarget.value);
    this.hiddenTarget.value = e.currentTarget.value;
  }

  updateText(element) {
    if (element == 0) {
      this.valueTarget.innerHTML = 0;
    }
    if (element == 1) {
      this.valueTarget.innerHTML = "Léger";
    }
    if (element == 2) {
      this.valueTarget.innerHTML = "Moyen";
    }
    if (element == 3) {
      this.valueTarget.innerHTML = "Grand";
    }
    if (element == 4) {
      this.valueTarget.innerHTML = "Permanent";
    }
    if (element == 5) {
      this.valueTarget.innerHTML = "Choc émotionnel";
    }
  }
}
