// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// バナー広告用Javascript
document.addEventListener("DOMContentLoaded", function () {
  const banner = document.getElementById('banner');
  const closeButton = document.getElementById('close-banner');
  
  closeButton.addEventListener('click', function() {
    banner.style.display = 'none';
    localStorage.setItem('bannerClosed', 'true');
    setTimeout(function() {
      localStorage.removeItem('bannerClosed');
      banner.style.display = 'block';
    }, 10000);
  });
  
  setTimeout(function() {
    if (!localStorage.getItem('bannerClosed')) {
      banner.style.display = 'block';
    }
  }, 10000);
});
