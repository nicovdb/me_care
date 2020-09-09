const fields = ['children', 'abortion', 'endo_surgery', 'miscarriage'];

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


const check_boxes_antecedents = document.querySelectorAll(`.information_family_antecedent .form-check-input`);

const family_boxes = document.querySelectorAll(`.information_fam_member_antes .form-check input`);

document.addEventListener("DOMContentLoaded", (event) => {
  if (document.getElementById(`information_family_antecedent_true`).checked) {
    document.querySelector(`.information_fam_member_antes`).disabled = false;
  } else {
    document.querySelector(`.information_fam_member_antes`).disabled = true;
  };
});

check_boxes_antecedents.forEach((button) => {
  button.addEventListener("click", (event) => {
    if (document.getElementById(`information_family_antecedent_true`).checked) {
      document.querySelector(`.information_fam_member_antes`).disabled = false;
    } else {
      family_boxes.forEach((button) => {
        button.checked = false;
      });
      document.querySelector(`.information_fam_member_antes`).disabled = true;
    };
  });
});


const check_boxes_auto_immune = document.querySelectorAll(`.information_auto_immune_antecedent .form-check-input`);

const auto_immune_boxes = document.querySelectorAll(`.information_diseases .form-check input`);

document.addEventListener("DOMContentLoaded", (event) => {
  if (document.getElementById(`information_auto_immune_antecedent_true`).checked) {
    document.querySelector(`.information_diseases`).disabled = false;
  } else {
    document.querySelector(`.information_diseases`).disabled = true;
  };
});

check_boxes_auto_immune.forEach((button) => {
  button.addEventListener("click", (event) => {
    if (document.getElementById(`information_auto_immune_antecedent_true`).checked) {
      document.querySelector(`.information_diseases`).disabled = false;
    } else {
      auto_immune_boxes.forEach((button) => {
        button.checked = false;
      });
      document.querySelector(`.information_diseases`).disabled = true;
    };
  });
});


const check_boxes_alternative_therapy = document.querySelectorAll(`.information_alternative_therapy .form-check-input`);

const alternative_therapy_boxes = document.querySelectorAll(`.information_alternative_therapies .form-check input`);

document.addEventListener("DOMContentLoaded", (event) => {
  if (document.getElementById(`information_alternative_therapy_true`).checked) {
    document.querySelector(`.information_alternative_therapies`).disabled = false;
  } else {
    document.querySelector(`.information_alternative_therapies`).disabled = true;
  };
});

check_boxes_alternative_therapy.forEach((button) => {
  button.addEventListener("click", (event) => {
    if (document.getElementById(`information_alternative_therapy_true`).checked) {
      document.querySelector(`.information_alternative_therapies`).disabled = false;
    } else {
      alternative_therapy_boxes.forEach((button) => {
        button.checked = false;
      });
      document.querySelector(`.information_alternative_therapies`).disabled = true;
    };
  });
});
