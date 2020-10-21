import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
flatpickr.localize(French);
flatpickr(".datepicker", {
  dateFormat: "d/m/Y"
});
