(function () {
  'use strict';
  var toggles = document.querySelectorAll('[data-password-toggle]');
  for (var i = 0; i < toggles.length; i++) {
    (function (button) {
      var field = document.getElementById(button.getAttribute('data-target'));
      if (!field) return;
      button.addEventListener('click', function () {
        var showing = field.type === 'password';
        field.type = showing ? 'text' : 'password';
        button.textContent = showing ? 'Ocultar' : 'Mostrar';
        button.setAttribute('aria-pressed', showing ? 'true' : 'false');
        button.setAttribute('aria-label', showing ? 'Ocultar senha' : 'Mostrar senha');
      });
    }(toggles[i]));
  }
}());
