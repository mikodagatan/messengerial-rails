$(document).ready(function() {
  $('.job-second').hide().removeClass('d-none');

  $('.job-container').click(function() {
    $(this).children('.job-second').slideToggle();
  });

});
