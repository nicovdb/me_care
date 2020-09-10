const photoPreview = () => {

    const input = document.getElementById('photo-input');
    if (input) {
      // we add a listener to know when a new picture is uploaded
      input.addEventListener('change', () => {
        // we call the displayPreview function (who retrieve the image url and display it)
        displayPreview(input);
      })
    }


  const displayPreview = (input) => {
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      const newAvatar = document.getElementById('photo-preview');
      const oldAvatar = document.getElementById('current-avatar');
      reader.onload = (event) => {
        newAvatar.src = event.currentTarget.result;
      }
      reader.readAsDataURL(input.files[0])
      console.log('hello');
      oldAvatar.classList.add('d-none');
      newAvatar.classList.remove('hidden');
      newAvatar.classList.add('avatar-xl');
    };
  };
};

export { photoPreview };
