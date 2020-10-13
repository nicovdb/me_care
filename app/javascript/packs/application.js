require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels");
require("thredded_imports.js");
require("trix");
require("@rails/actiontext");
require('packs/social-share-button.js.erb');

// External imports
import "bootstrap";
import "../plugins/flatpickr";

// Internal imports
import "controllers"
import { navbarMenu } from '../components/navbar_menu';
import { photoPreview } from '../components/photo_preview';
import { formInformation } from '../components/form_information';

document.addEventListener('turbolinks:load', () => {
  navbarMenu();
  formInformation();
  photoPreview();
});

