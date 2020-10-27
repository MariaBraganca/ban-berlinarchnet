import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css'

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    enableTime: true,
    time_24hr: true,
    dateFormat: "Y-m-d H:i",
    altInput: true,
    minDate: "today"
  });
  const location =document.querySelector('#event_location')
  if(location) {
    var placesAutocomplete = places({
      appId: 'pl8XQR7LGT3A',
      apiKey: '97cf4ef438588fd18d8ebb1f470b59bb',
      container: document.querySelector('#event_location'),
      templates: {
      value: function(suggestion) {
      return `${suggestion.name}, ${suggestion.postcode}, ${suggestion.city}`;
    }
    }
    }).configure({
    type: 'address'
    });
  }
};

export { initFlatpickr };