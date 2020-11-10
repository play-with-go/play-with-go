$(() => {
  $(".show-wizard").click(() => {
     //ga('send', 'event', 'Menu', 'click-wizard');
    $("#welcomeModal").modal();
  });
  $("#help").click(() => {
     //ga('send', 'event', 'Menu', 'click-help');
    $("#helpModal").modal();
  });
});
