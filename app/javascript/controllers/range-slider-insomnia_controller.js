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
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia1.svg'>";
    }
    if (element == 1) {
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia2.svg'>";
    }
    if (element == 2) {
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia3.svg'>";
    }
    if (element == 3) {
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia4.svg'>";
    }
    if (element == 4) {
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia5.svg'>";
    }
    if (element == 5) {
      this.valueTarget.innerHTML = "<img class='insomnia-icon mb-1' src='/assets/agenda/insomnia6.svg'>";
    }
  }
}
