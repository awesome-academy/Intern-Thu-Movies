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

  $('#rate-show').hide();

  $("#social").on("click", "#rate-star", function () {
    $("#rate-show").toggle();
  });

  $('.click-rate').on('click', function () {
    $('#rate-show').hide();
  });

  $('.total-rating').hide();

  $('#score').on('click', function () {
    $('.total-rating').toggle();
  });
});
