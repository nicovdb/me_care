import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output", "size", "weight" ]

  compute() {
    const num = this.weightTarget.value / Math.pow(this.sizeTarget.value / 100, 2);
    this.outputTarget.value = Math.round(num * 10) / 10;
  }
}
