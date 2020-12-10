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
      this.valueTarget.innerHTML = "Traces marrons";
    }
    if (element == 2) {
      this.valueTarget.innerHTML = "Un protège-slip suffit";
    }
    if (element == 3) {
      this.valueTarget.innerHTML = "Comme des règles";
    }
    if (element == 4) {
      this.valueTarget.innerHTML = "Abondant";
    }
    if (element == 5) {
      this.valueTarget.innerHTML = "Hémorragique";
    }
  }
}
