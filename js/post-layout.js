---
---
// replaceAll is a basic alternative to String.prototype.replaceAll which has not
// yet landed in all browsers
function replaceAll(string, search, replace) {
  return string.split(search).join(replace);
}
function replaceInText(element, replacements) {
  let v = element.innerHTML;
  for (let r of replacements) {
    v = replaceAll(v, r[0], r[1]);
  }
  element.innerHTML = v;
}

function login() {
  localStorage.setItem("authenticated", false);
  document.location.href = "/index.html";
}
var siteUrl = "{{ site.url }}";
var fontChanged = false;
var pwd = new PWD();

pwd.on("instanceCreate", function(instance) {
  instance.terms[0].write(`$ \r\n`);
  $("pre[data-upload-src], pre[data-command-src]").on("click", function() {
    $(this).addClass("completed");
  });
});
pwd.on("unauthorized", function() {
  login();
});

var guideRequest = new XMLHttpRequest();
// TODO: move away from hard-code guides URL to use a variable
// specified in the site config
guideRequest.open('POST', '{{ site.controllerurl }}');
guideRequest.withCredentials = true;
guideRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
guideRequest.onerror = function() {
  $(".term-init").text("Error initializing environment, please raise an issue using the help link.");
}
guideRequest.onload = function() {
  // TODO: error handling
  if (guideRequest.status > 500) {
    throw "Failed to make guides request";
  } else if (guideRequest.status == 401) {
    login();
  }
  var guideDetails = JSON.parse(guideRequest.responseText);

  let replacements = [];
  if (guideDetails.Env != null) {
    for (let env of guideDetails.Env) {
      let parts = env.split("=", 2);
      replacements.push([guideDetails.Delims[0]+"."+parts[0]+guideDetails.Delims[1], parts[1]]);
    }
  }
  replaceInText(document.querySelector("article"), replacements);
  for (let attr of ["data-upload-src", "data-command-src", "data-upload-path"]) {
    document.querySelectorAll("["+attr+"]").forEach(function(node) {
      let na = data = node.getAttribute(attr);
      let prefix = "";
      if (attr == "data-upload-src") {
        let parts = na.split(":");
        prefix = atob(parts[0])+":";
        data = parts[1];
      }
      let v = atob(data);
      for (let r of replacements) {
        v = replaceAll(v, r[0], r[1]);
        prefix = replaceAll(prefix, r[0], r[1]);
      }
      if (attr != "data-upload-path") {
        v = btoa(v);
      }
      node.setAttribute(attr, prefix+v);

    });
  }
  pwd.newSession(guideDetails.Terminals, { baseUrl: "{{site.pwdurl}}", Networks: guideDetails.Networks, Envs: guideDetails.Env }, function(err) {
    if (err) {
      $(".term-init").text("Error initializing environment, please try again or submit an issue if problem persists.");
      return
    }
    $(".term-init").remove();
  });
};
guideRequest.send(JSON.stringify({Guide: pageGuide, Language: pageLanguage, Scenario: pageScenario}));

$(".panel-left").resizable({
  handleSelector: ".splitter",
  resizeHeight: false,
  onDragEnd: pwd.resize.bind(pwd)
});

$(document).ready(function() {
  $(".nav a").on("click", function() {
    let sel = $(".tab-pane.active").get(0);
    sel.style.display = "none";
    sel.offsetHeight; // no need to store this anywhere, the reference is enough
    sel.style.display = "";
  });


  //Resize when switching terminals
  //Not needed since we have a single term
  //$(".nav-tabs .nav-item").on("click",()=>{
    //pwd.resize()
  //})

  // expand/shrink terminals
  $(".fa-expand").on("click", function() {
    const leftPanel = $(".panel-left");
    const menuPanel = $(".menu-panel");
    leftPanel.toggle();
    menuPanel.hide();
    const terminalOpened = leftPanel.is(":hidden");
    // add compress icon if leftPanel is open
    $(this).toggleClass("fa-compress", terminalOpened);
    pwd.resize();
  });



});

// progress bar

function scrollHandler() {
  const scrollTop = $(this).scrollTop();
  const scrollHeight = $(this).prop("scrollHeight");
  const height = $(this).height();
  const progress = ((scrollTop + height) / scrollHeight) * 100;
  const entireProgress = Math.ceil(scrollTop ? progress : 0);

  $(".progress-bar").width(entireProgress + "%");
  $(".progress-bar").attr("data-progress", entireProgress || null);
}

$(() => {
  $(".post.content").on("scroll", scrollHandler);
});
