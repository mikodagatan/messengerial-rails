$(document).on('turbolinks:load', function() {
  $('.task-second').hide().removeClass('d-none');

  $('.task-first').click(function() {
    $(this).next('.task-second').slideToggle();
  });

});
