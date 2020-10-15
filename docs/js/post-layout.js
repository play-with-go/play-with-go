// replaceAll is a basic alternative to String.prototype.replaceAll which has not
// yet landed in all browsers
function replaceAll(string, search, replace) {
  return string.split(search).join(replace);
}
function replaceInText(element, replacements) {
	for (let node of element.childNodes) {
		switch (node.nodeType) {
			case Node.ELEMENT_NODE:
				replaceInText(node, replacements);
				break;
			case Node.TEXT_NODE:
				for (let r of replacements) {
					node.textContent = replaceAll(node.textContent, r[0], r[1]);
				}
				break;
			case Node.DOCUMENT_NODE:
				replaceInText(node, replacements);
		}
	}
}
var siteUrl = "https://docker-labs.com";
var fontChanged = false;
var pwd = new PWD();
var guideRequest = new XMLHttpRequest();
// TODO: move away from hard-code guides URL to use a variable
// specified in the site config
guideRequest.open('POST', 'https://api.play-with-go.dev/guides');
guideRequest.withCredentials = true;
guideRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
guideRequest.onload = function() {
	// TODO: error handling
	if (guideRequest.status != 200) {
		throw "Failed to make guides request";
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
	pwd.newSession(guideDetails.Terminals, { baseUrl: "https://api.play-with-go.dev", oauthProvider: 'google', Networks: guideDetails.Networks, Envs: guideDetails.Env });
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
