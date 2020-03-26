window.onbeforeunload = function(e) {
  return true;
};

window.onunload = function(e) {
  pwd.closeSession(function() {});
}
