var siteUrl = "http://0.0.0.0:4000";
var fontChanged = false;
pwd.newSession(
  [{ selector: ".term1" }, { selector: ".term2" }, { selector: ".term3" }],
  { baseUrl: "https://labs.play-with-docker.com", ImageName: imageName }
);
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
  // expand/shrink terminals
  $(".fa-expand").on("click", function() {
    const leftPanel = $(".panel-left");
    const menuPanel = $(".menu-panel");
    leftPanel.toggle();
    menuPanel.hide();
    const terminalOpened = leftPanel.is(":hidden");
    // add compress icon if leftPanel is open
    $(this).toggleClass("fa-compress", terminalOpened);
    setMenuButtonIcon();
    pwd.resize();
  });

  // toggle menu
  $(".course-index-button").on("click", function() {
    const menuPanel = $(".menu-panel");
    menuPanel.toggle();
    setMenuButtonIcon();
  });

  const setMenuButtonIcon = () => {
    const menuPanel = $(".menu-panel");
    const menuButtom = $(".menu-button");
    const menuIsOpen = menuPanel.is(":visible");
    menuButtom.toggleClass("fa-times", menuIsOpen);
    menuButtom.toggleClass("fa-bars", !menuIsOpen);
  };

  /*$('.btn-text').on('click', function(){
          if (fontChanged) {
              $('.terminal').css('font-size', '15px').css('line-height', '17px');
          } else {
              $('.terminal').css('font-size', '20px').css('line-height', '22px');
          }
          $(window).trigger('resize');
          fontChanged = !fontChanged;
      });*/
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
