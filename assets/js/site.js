// Club Curated – tabs, accordions, gallery. No dependencies.
(function () {
  // FAQ tabs + accordions
  document.querySelectorAll('[data-faq]').forEach(function (faq) {
    var tabs = Array.prototype.slice.call(faq.querySelectorAll('[role=tab]'));
    function select(tab, focus) {
      tabs.forEach(function (t) {
        var on = t === tab;
        t.setAttribute('aria-selected', on ? 'true' : 'false');
        t.tabIndex = on ? 0 : -1;
        document.getElementById(t.getAttribute('aria-controls')).hidden = !on;
      });
      if (focus) tab.focus();
    }
    tabs.forEach(function (tab, i) {
      tab.tabIndex = i === 0 ? 0 : -1;
      tab.addEventListener('click', function () { select(tab); });
      tab.addEventListener('keydown', function (e) {
        var d = e.key === 'ArrowRight' ? 1 : e.key === 'ArrowLeft' ? -1 : 0;
        if (d) { e.preventDefault(); select(tabs[(i + d + tabs.length) % tabs.length], true); }
      });
    });
    faq.querySelectorAll('.acc-head').forEach(function (head) {
      head.addEventListener('click', function () {
        var open = head.getAttribute('aria-expanded') === 'true';
        head.setAttribute('aria-expanded', open ? 'false' : 'true');
        document.getElementById(head.getAttribute('aria-controls')).hidden = open;
      });
    });
  });

  // Photo gallery
  document.querySelectorAll('[data-gallery]').forEach(function (g) {
    var track = g.querySelector('.gallery-track');
    var prev = g.querySelector('.prev'), next = g.querySelector('.next');
    function step() { var img = track.querySelector('img'); return (img ? img.offsetWidth : 375) + 10; }
    function update() {
      prev.hidden = track.scrollLeft < 4;
      next.hidden = track.scrollLeft + track.clientWidth > track.scrollWidth - 4;
    }
    prev.addEventListener('click', function () { track.scrollBy({ left: -step(), behavior: 'smooth' }); });
    next.addEventListener('click', function () { track.scrollBy({ left: step(), behavior: 'smooth' }); });
    track.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', update);
    // the original starts with the first photo slightly off-screen
    if (window.innerWidth > 720 && track.scrollWidth > track.clientWidth) track.scrollLeft = 86;
    update();
  });

  // Touch devices: first tap on "Studios" opens the sub-menu instead of navigating
  var sub = document.querySelector('.has-sub > .pill');
  if (sub && window.matchMedia('(hover: none)').matches) {
    var opened = false;
    sub.addEventListener('click', function (e) { if (!opened) { e.preventDefault(); opened = true; sub.focus(); } });
    sub.addEventListener('blur', function () { setTimeout(function () { opened = false; }, 300); });
  }
})();
