import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "all", "cross" ]

  connect() {
    this.filteredValue = false
  }

  toggle(e) {
    if (this.filteredValue == false) {
      this.hideAll()
      this.filteredValue = true
    }

    const symptom = e.target.dataset.symptom
    e.target.parentElement.classList.toggle("underline")
    this.toggleSymptom(symptom)
  }

  hideAll() {
    this.allTargets.forEach((target) => {
      if (!target.classList.contains("d-none")) {
        target.classList.add("d-none")
      }
    })
    this.crossTargets.forEach((target) => {
      if (!target.classList.contains("d-none")) {
        target.classList.add("d-none")
      }
    })
  }

  toggleSymptom(symptom) {
    const symptomTargets = document.querySelectorAll(`[data-symptom-target=${symptom}]`)
    symptomTargets.forEach((target) => {
      target.classList.toggle("d-none")
    })
  }

  resetFilters() {
    this.allTargets.forEach((target) => {
      if (target.classList.contains("d-none")) {
        target.classList.remove("d-none")
      }
    })
    this.crossTargets.forEach((target) => {
      if (!target.classList.contains("d-none")) {
        target.classList.add("d-none")
      }
    })
    const filterTitles = document.querySelectorAll("h3[data-symptom]")
    filterTitles.forEach((filter) => {
      filter.parentElement.classList.remove("underline")
    })
    this.filteredValue = false
  }
}
