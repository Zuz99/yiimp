/* Yiimp Theme + Sidebar (UI only) */
(function(){
  // Dark mode only
  var defaultTheme = 'red-dark';

  function applyTheme(theme){
    try{
      document.documentElement.setAttribute('data-theme', theme);
    }catch(e){}
  }

  function initTheme(){
    applyTheme(defaultTheme);
  }

  function initSidebar(){
    var btn = document.getElementById('sidebarToggle');
    var backdrop = document.getElementById('appBackdrop');
    if(btn){
      btn.addEventListener('click', function(){
        document.body.classList.toggle('sidebar-open');
      });
    }
    if(backdrop){
      backdrop.addEventListener('click', function(){
        document.body.classList.remove('sidebar-open');
      });
    }
    // close sidebar on escape
    document.addEventListener('keydown', function(e){
      if(e.key === 'Escape'){
        document.body.classList.remove('sidebar-open');
      }
    });
  }

  document.addEventListener('DOMContentLoaded', function(){
    initTheme();
    initSidebar();
  });
})();
