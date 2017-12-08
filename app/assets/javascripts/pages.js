$(document).on('turbolinks:load', function() {
  $('.job-second').hide().removeClass('d-none');

  $('.job-first').click(function() {
    $(this).next('.job-second').slideToggle();
  });

});
