import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    window.addEventListener("trix-file-accept", function(event) {
      event.preventDefault()
      alert("Vous ne pouvez pas insérer de fichier dans votre commentaire.")
    })
  }
}
