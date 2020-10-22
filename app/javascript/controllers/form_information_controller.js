import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "familyAntecedent", "alternativeTherapy", "autoImmuneAntecedent", "children", "miscarriage", "abortion", "endoSurgery"  ]

  connect() {
    this.disableAll()
    this.checkToEnable()

  }

  disableAll() {
    this.familyAntecedentTarget.disabled = true
    this.autoImmuneAntecedentTarget.disabled = true
    this.alternativeTherapyTarget.disabled = true
    this.childrenTarget.disabled = true
    this.miscarriageTarget.disabled = true
    this.abortionTarget.disabled = true
    this.endoSurgeryTarget.disabled = true
  }

  checkToEnable() {
    const radioButtons = document.querySelectorAll("[data-name]")
    radioButtons.forEach((radioButton) => {
      if (radioButton.value == "true" && radioButton.checked == true) {
        const name = radioButton.getAttribute("data-name")
        document.querySelector(`[data-target="form-information.${name}"]`).disabled = false
      }
    })
  }

  ableOrDisableCheckbox(e) {
    const targetName = e.target.getAttribute("data-name")
    const target = document.querySelector(`[data-target="form-information.${targetName}"]`)

    if (e.target.value == "true") {
      target.disabled = false
    } else {
      target.disabled = true
      this.uncheckChildrenCheckbox(target)
    }
  }

  ableOrDisableInput(e) {
    const targetName = e.target.getAttribute("data-name")
    const target = document.querySelector(`[data-target="form-information.${targetName}"]`)

    if (e.target.value == "true") {
      target.disabled = false
    } else {
      target.disabled = true
      target.value = null
    }
  }

  uncheckChildrenCheckbox(target) {
    target.querySelectorAll(".form-check-input").forEach((checkbox) => {
      checkbox.checked = false
    })
  }
}
