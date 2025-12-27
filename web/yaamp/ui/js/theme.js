/*
  Yiimp UI Theme Switcher
  - purely visual (no functional impact)
  - stores selection in cookie: yiimp_theme
*/
(function () {
  'use strict';

  var COOKIE = 'yiimp_theme';
  var THEMES = ['midnight','aurora','rainbow'];

  function getCookie(name) {
    var m = document.cookie.match(new RegExp('(?:^|; )' + name.replace(/[.$?*|{}()\[\]\\\/\+^]/g, '\\$&') + '=([^;]*)'));
    return m ? decodeURIComponent(m[1]) : '';
  }

  function setCookie(name, value, days) {
    var expires = '';
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = '; expires=' + date.toUTCString();
    }
    document.cookie = name + '=' + encodeURIComponent(value) + expires + '; path=/';
  }

  function applyTheme(theme) {
    if (THEMES.indexOf(theme) === -1) theme = 'midnight';

    var body = document.body;
    if (!body) return;

    // Remove previous theme classes
    for (var i = 0; i < THEMES.length; i++) {
      body.classList.remove('theme-' + THEMES[i]);
    }
    body.classList.add('theme-' + theme);

    var picker = document.getElementById('themePicker');
    if (picker) picker.value = theme;
  }

  function init() {
    var current = getCookie(COOKIE) || 'midnight';
    applyTheme(current);

    var picker = document.getElementById('themePicker');
    if (picker && !picker.__yiimpThemeBound) {
      picker.__yiimpThemeBound = true;
      picker.addEventListener('change', function () {
        var v = (picker.value || '').trim();
        if (THEMES.indexOf(v) === -1) v = 'midnight';
        setCookie(COOKIE, v, 365);
        applyTheme(v);
      });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
