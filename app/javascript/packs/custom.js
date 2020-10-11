$(function () {
  $('.card-movie').hover(
    function () {
      $(this).addClass('shadow-lg').css('cursor', 'pointer');
    },
    function () {
      $(this).removeClass('shadow-lg');
    }
  );
  $('.all-form').hide();

  $('#comment').on('click', '.reply', function () {
    let replyId = $(this).attr('data');

    $('.' + replyId).toggle();
  });
});
