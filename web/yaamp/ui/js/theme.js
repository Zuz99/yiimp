(function () {
  'use strict';

  var STORAGE_KEY = 'yiimp-theme';

  function getPreferredTheme() {
    var saved = null;
    try { saved = localStorage.getItem(STORAGE_KEY); } catch (e) {}
    if (saved === 'light' || saved === 'dark') return saved;
    // system
    return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-bs-theme', theme);
    document.documentElement.setAttribute('data-theme', theme);

    var btn = document.getElementById('yiimpThemeToggle');
    if (!btn) return;

    var icon = btn.querySelector('i');
    var label = btn.querySelector('.yiimp-theme-label');

    if (theme === 'dark') {
      if (icon) icon.className = 'bi bi-moon-stars-fill';
      if (label) label.textContent = 'Dark';
      btn.setAttribute('aria-label', 'Switch to light theme');
    } else {
      if (icon) icon.className = 'bi bi-sun-fill';
      if (label) label.textContent = 'Light';
      btn.setAttribute('aria-label', 'Switch to dark theme');
    }
  }

  function setTheme(theme) {
    try { localStorage.setItem(STORAGE_KEY, theme); } catch (e) {}
    applyTheme(theme);
  }

  function toggleTheme() {
    var current = document.documentElement.getAttribute('data-bs-theme') || getPreferredTheme();
    setTheme(current === 'dark' ? 'light' : 'dark');
  }

  // Init early
  applyTheme(getPreferredTheme());

  window.addEventListener('DOMContentLoaded', function () {
    var btn = document.getElementById('yiimpThemeToggle');
    if (btn) btn.addEventListener('click', function (e) {
      e.preventDefault();
      toggleTheme();
    });

    // Watch system theme changes when user has not explicitly set a preference
    var hasSaved = false;
    try { hasSaved = !!localStorage.getItem(STORAGE_KEY); } catch (e) {}
    if (!hasSaved && window.matchMedia) {
      var mq = window.matchMedia('(prefers-color-scheme: dark)');
      if (mq && mq.addEventListener) {
        mq.addEventListener('change', function () { applyTheme(getPreferredTheme()); });
      } else if (mq && mq.addListener) {
        mq.addListener(function () { applyTheme(getPreferredTheme()); });
      }
    }
  });
})();
