---
---
var siteUrl = "{{ site.url }}";
var fontChanged = false;
var pwd = new PWD();
var guideRequest = new XMLHttpRequest();
// TODO: move away from hard-code guides URL to use {{ page.guide }}
guideRequest.open('GET', '{{site.pwdurl}}/guides/2019-03-19-using-go-modules');
guideRequest.withCredentials = true;
guideRequest.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
guideRequest.onload = function() {
	console.log("We got a response", guideRequest)
	// TODO: error handling
	if (guideRequest.status != 200) {
		return;
	}
	var sessionData = JSON.parse(guideRequest.responseText);
	pwd.init(
		sessionData.session_id,
		{ baseUrl: "{{site.pwdurl}}", ImageName: imageName, oauthProvider: 'google' },
		function() {
			var instances = [];
			for (name in pwd.instances) {
				instances.push(pwd.instances[name]);
			}
			pwd.createTerminal({ selector: ".term1" }, instances[0].name);
		}
	);
};
guideRequest.send();
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
  $(".nav-tabs .nav-item").on("click",()=>{
    pwd.resize()
  })
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
