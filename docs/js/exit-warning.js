window.addEventListener('beforeunload', function (e) {
  navigator.sendBeacon("http://api.play-with-go.dev/sessions/" + pwd.sessionId + "/close");
  // Cancel the event
  e.preventDefault();
  // Chrome requires returnValue to be set
  e.returnValue = '';
});

