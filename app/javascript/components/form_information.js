const fields = ['children', 'abortion', 'endo_surgery'];

fields.forEach((field) => {
  const radio_buttons = document.querySelectorAll(`.information_${field} input`);
  radio_buttons.forEach((button) => {
    button.addEventListener("click", (event) => {
      if (document.getElementById(`information_${field}_true`).checked) {
        document.getElementById(`information_${field}_number`).disabled = false;
      } else {
        document.getElementById(`information_${field}_number`).value = null;
        document.getElementById(`information_${field}_number`).disabled = true;
      };
    });
  });
})
