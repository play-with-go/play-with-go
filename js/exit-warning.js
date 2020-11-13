---
---
window.addEventListener('beforeunload', function (e) {
  // Cancel the event
  e.preventDefault();
  // Chrome requires returnValue to be set
  e.returnValue = '';
});

window.addEventListener('unload', function(e) {
  navigator.sendBeacon("{{site.pwdurl}}/sessions/" + pwd.sessionId + "/close");
});

