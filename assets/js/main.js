/* SIGBIT — progressive enhancement only. Every page works without this file. */
(function () {
  "use strict";

  /* ---- Mobile menu ---- */
  var btn = document.querySelector(".menu-btn");
  var nav = document.getElementById("nav");

  if (btn && nav) {
    btn.addEventListener("click", function () {
      var open = nav.classList.toggle("is-open");
      btn.setAttribute("aria-expanded", open ? "true" : "false");
    });
    nav.addEventListener("click", function (e) {
      if (e.target.tagName === "A") {
        nav.classList.remove("is-open");
        btn.setAttribute("aria-expanded", "false");
      }
    });
    window.addEventListener("resize", function () {
      if (window.innerWidth > 820) {
        nav.classList.remove("is-open");
        btn.setAttribute("aria-expanded", "false");
      }
    });
  }

  /* ---- Mark the current page in the top nav ---- */
  var here = location.pathname.split("/").pop() || "index.html";
  Array.prototype.forEach.call(document.querySelectorAll("#nav a"), function (a) {
    if (a.getAttribute("href") === here) {
      a.classList.add("is-current");
      a.setAttribute("aria-current", "page");
    }
  });

  /* ---- Spine: light up the block currently in view ---- */
  var links = Array.prototype.slice.call(document.querySelectorAll(".chain a"));
  if (!links.length || !("IntersectionObserver" in window)) return;

  var byId = {};
  var targets = [];
  links.forEach(function (a) {
    var el = document.getElementById(a.getAttribute("href").slice(1));
    if (el) { byId[el.id] = a; targets.push(el); }
  });

  var visible = {};
  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      visible[entry.target.id] = entry.isIntersecting;
    });
    var current = null;
    targets.forEach(function (el) { if (visible[el.id] && !current) current = el.id; });
    links.forEach(function (a) { a.classList.remove("is-active"); });
    if (current && byId[current]) byId[current].classList.add("is-active");
  }, { rootMargin: "-45% 0px -45% 0px", threshold: 0 });

  targets.forEach(function (el) { observer.observe(el); });
})();
