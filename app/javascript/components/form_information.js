const formInformation = () => {
  const check_boxes_antecedents = document.querySelectorAll('.information_family_antecedent .form-check-input');
  const family_boxes = document.querySelectorAll('.information_fam_member_antes .form-check input');
  const check_boxes_auto_immune = document.querySelectorAll('.information_auto_immune_antecedent .form-check-input');
  const auto_immune_boxes = document.querySelectorAll('.information_diseases .form-check input');
  const check_boxes_alternative_therapy = document.querySelectorAll('.information_alternative_therapy .form-check-input');
  const alternative_therapy_boxes = document.querySelectorAll('.information_alternative_therapies .form-check input');
  const list_checkboxes_alt_therapies = document.querySelector('.information_alternative_therapies');
  const list_checkboxes_auto_immune_atcd = document.querySelector('.information_diseases');
  const true_checkbox_alt_therapies = document.getElementById('information_alternative_therapy_true');
  const true_checkbox_auto_immune_atcd = document.getElementById('information_auto_immune_antecedent_true');
  const nameFieldDisease = document.querySelector('.information_diseases_name input');
  const nameFieldTherapy = document.querySelector('.information_alternative_therapies_name input');
  const checkboxDiseaseOtherLabel = document.querySelector('#checkbox-diseases label');
  const checkboxTherapiesOtherLabel = document.querySelector('#checkbox-alt-therapies label');

  const disable_checkboxes_alt_therapies = () => {
    list_checkboxes_alt_therapies.disabled = true;
    if (nameFieldTherapy) {
      nameFieldTherapy.disabled = true;
      nameFieldTherapy.value = null;
    };
    if (checkboxTherapiesOtherLabel) {
      checkboxTherapiesOtherLabel.classList.add('disabled-opacity');
    };
  };

  const enable_checkboxes_alt_therapies = () => {
    list_checkboxes_alt_therapies.disabled = false;
    if (checkboxTherapiesOtherLabel) {
      checkboxTherapiesOtherLabel.classList.remove('disabled-opacity');
    };
    if (nameFieldTherapy) {
      nameFieldTherapy.disabled = false;
      nameFieldTherapy.value = null;
    };
  };

  const disable_checkboxes_auto_immune_atcd = () => {
    list_checkboxes_auto_immune_atcd.disabled = true;
    if (nameFieldDisease) {
      nameFieldDisease.disabled = true;
      nameFieldDisease.value = null;
    };
    if (checkboxDiseaseOtherLabel) {
      checkboxDiseaseOtherLabel.classList.add('disabled-opacity');
    };
  };

  const enable_checkboxes_auto_immune_atcd = () => {
    list_checkboxes_auto_immune_atcd.disabled = false;
    if (nameFieldDisease) {
      nameFieldDisease.disabled = false;
    };
    if (checkboxDiseaseOtherLabel) {
      checkboxDiseaseOtherLabel.classList.remove('disabled-opacity');
    };
  };


  if (check_boxes_antecedents.length != 0) {
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

    if (document.readyState !== 'loading') {
      if (document.getElementById('information_family_antecedent_true').checked) {
        document.querySelector('.information_fam_member_antes').disabled = false;
      } else {
        document.querySelector('.information_fam_member_antes').disabled = true;
      };
    } else {
        document.addEventListener("DOMContentLoaded", (event) => {
        if (document.getElementById('information_family_antecedent_true').checked) {
          document.querySelector('.information_fam_member_antes').disabled = false;
        } else {
          document.querySelector('.information_fam_member_antes').disabled = true;
        };
      });
    }

    check_boxes_antecedents.forEach((button) => {
      button.addEventListener("click", (event) => {
        if (document.getElementById('information_family_antecedent_true').checked) {
          document.querySelector('.information_fam_member_antes').disabled = false;
        } else {
          family_boxes.forEach((button) => {
            button.checked = false;
          });
          document.querySelector('.information_fam_member_antes').disabled = true;
        };
      });
    });

    if( document.readyState !== 'loading' ) {
      if (true_checkbox_auto_immune_atcd.checked) {
        enable_checkboxes_auto_immune_atcd();
      } else {
        disable_checkboxes_auto_immune_atcd();
      };
    } else {
        document.addEventListener("DOMContentLoaded", (event) => {
          if (true_checkbox_auto_immune_atcd.checked) {
            enable_checkboxes_auto_immune_atcd();
          } else {
            disable_checkboxes_auto_immune_atcd();
          };
        });
    }

    check_boxes_auto_immune.forEach((button) => {
      button.addEventListener("click", (event) => {
        if (true_checkbox_auto_immune_atcd.checked) {
          enable_checkboxes_auto_immune_atcd();
        } else {
          auto_immune_boxes.forEach((button) => {
            button.checked = false;
          });
          disable_checkboxes_auto_immune_atcd();
          list_checkboxes_auto_immune_atcd.value = null;
        };
      });
    });



    if( document.readyState !== 'loading' ) {
      if (true_checkbox_alt_therapies.checked) {
        enable_checkboxes_alt_therapies();
      } else {
        disable_checkboxes_alt_therapies();
      };
    } else {
      document.addEventListener("DOMContentLoaded", (event) => {
        if (true_checkbox_alt_therapies.checked) {
          enable_checkboxes_alt_therapies();
        } else {
          disable_checkboxes_alt_therapies();
        };
      });
    }

    check_boxes_alternative_therapy.forEach((button) => {
      button.addEventListener("click", (event) => {
        if (true_checkbox_alt_therapies.checked) {
          enable_checkboxes_alt_therapies();
        } else {
          alternative_therapy_boxes.forEach((button) => {
            button.checked = false;
          });
          disable_checkboxes_alt_therapies();
        };
      });
    });
  };
};

export { formInformation }
