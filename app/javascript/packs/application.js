require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("trix");
require("@rails/actiontext");

// External imports
import "bootstrap";
import "../plugins/flatpickr";

// Internal imports
import "controllers";
import { navbarMenu } from '../components/navbar_menu';

document.addEventListener('turbolinks:load', () => {
  navbarMenu();
});

