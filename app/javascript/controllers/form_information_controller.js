import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "familyAntecedent", "alternativeTherapy", "autoImmuneAntecedent", "children", "miscarriage", "abortion", "endoSurgery"  ]

  connect() {
    this.disableAll()
    this.checkToEnable()

  }

  disableAll() {
    this.familyAntecedentTarget.disabled = true
    this.autoImmuneAntecedentTargets.forEach((target) => {
      target.disabled = true
    })
    this.alternativeTherapyTargets.forEach((target) => {
      target.disabled = true
    })
    this.childrenTarget.disabled = true
    this.miscarriageTarget.disabled = true
    this.abortionTarget.disabled = true
    this.endoSurgeryTarget.disabled = true
  }

  checkToEnable() {
    const radioButtons = document.querySelectorAll("[data-name]")
    radioButtons.forEach((radioButton) => {
      if (radioButton.value == "true" && radioButton.checked == true) {
        const targetName = radioButton.getAttribute("data-name")
        const targets = document.querySelectorAll(`[data-target="form-information.${targetName}"]`)
        targets.forEach((target) => {
          target.disabled = false
        })
      }
    })
  }

  enableOrDisable(event) {
    const targetName = event.target.getAttribute("data-name")
    const targets = document.querySelectorAll(`[data-target="form-information.${targetName}"]`)

    if (event.target.value == "true") {
      targets.forEach((target) => {
        target.disabled = false
      })
    } else {
      targets.forEach((target) => {
        target.disabled = true

        if (target.type == "fieldset") {
          this.uncheckChildrenCheckbox(target)
        } else {
          target.value = null
        }
      })
    }
  }

  uncheckChildrenCheckbox(target) {
    target.querySelectorAll(".form-check-input").forEach((checkbox) => {
      checkbox.checked = false
    })
  }
}
