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
      this.valueTarget.innerHTML = "";
    }
    else if (element == 1) {
      this.valueTarget.innerHTML = "1 fois";
    }
    else if (element == 2) {
      this.valueTarget.innerHTML = "2 à 3 fois";
    }
    else if (element == 3) {
      this.valueTarget.innerHTML = "4 à 5 fois";
    }
    else if (element == 4) {
      this.valueTarget.innerHTML = "> 5";
    }
    else if (element == 5) {
      this.valueTarget.innerHTML = "Invalidant";
    }
  }
}
