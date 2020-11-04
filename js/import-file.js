pwd.on("uploadEnd", function(err, path, instance) {
  if (err) {
    feedbackFooter.negativeFeedback(
      "Something went uploading file wrong. Please try again."
    );
    return
  }
  instance.terms[0].write(`# File uploaded to ${path} successfully.\r\n$ `);
});

function getSelectedTermInstance() {
  return Object.keys(pwd.instances)
    .map(k => pwd.instances[k])
    .find(i =>
      $(i.terms[0].element)
        .parent()
        .hasClass("active")
    );
}
