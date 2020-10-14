import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "photoPreview", "currentAvatar" ]

  display(event) {
    const input = event.target
    if (input.files && input.files[0]) {
      const reader = new FileReader()
      const newAvatar = this.photoPreviewTarget
      const oldAvatar = this.currentAvatarTarget
      reader.onload = (event) => {
        newAvatar.src = event.currentTarget.result;
      }
      reader.readAsDataURL(input.files[0])
      oldAvatar.classList.add('d-none');
      newAvatar.classList.remove('hidden');
      newAvatar.classList.add('avatar-xl');
    };
  }
}
