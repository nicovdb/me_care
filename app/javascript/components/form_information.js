const radio_buttons_children = document.querySelectorAll('.information_children input');
console.log(radio_buttons_children);
radio_buttons_children.forEach((button) => {
  button.addEventListener("click", (event) => {
    console.log(event);
    console.log(event.currentTarget);
    if (document.getElementById('information_children_true').checked) {
      document.getElementById('information_children_number').disabled = false;
    } else {
      document.getElementById('information_children_number').value = null;
      document.getElementById('information_children_number').disabled = true;
    };
  });
});

const radio_buttons_abortion = document.querySelectorAll('.information_abortion input');
console.log(radio_buttons_abortion);
radio_buttons_abortion.forEach((button) => {
  button.addEventListener("click", (event) => {
    console.log(event);
    console.log(event.currentTarget);
    if (document.getElementById('information_abortion_true').checked) {
      document.getElementById('information_abortion_number').disabled = false;
    } else {
      document.getElementById('information_abortion_number').value = null;
      document.getElementById('information_abortion_number').disabled = true;
    };
  });
});

const radio_buttons_endo_surgery = document.querySelectorAll('.information_endo_surgery input');
console.log(radio_buttons_endo_surgery);
radio_buttons_endo_surgery.forEach((button) => {
  button.addEventListener("click", (event) => {
    console.log(event);
    console.log(event.currentTarget);
    if (document.getElementById('information_endo_surgery_true').checked) {
      document.getElementById('information_endo_surgery_number').disabled = false;
    } else {
      document.getElementById('information_endo_surgery_number').value = null;
      document.getElementById('information_endo_surgery_number').disabled = true;
    };
  });
});



