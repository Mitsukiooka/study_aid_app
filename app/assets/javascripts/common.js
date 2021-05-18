$(function() {
  $('.search-plan').on('keyup', function() {
    var title = $.trim($(this).val());
    $.ajax({
      type: 'GET',
      url: '/login/plans/suggest',
      data: { title: title },
      dataType: 'json'
    })
    .done(function(data){
      var suggestBox = $('.js-plans')
      suggestBox.show();
      $('.js-plans li').remove();
      $(data).each(function (i, plan){
        suggestBox.append(
          `<li><a href="/login/plans/${plan.id}">${plan.title}</a></li>`
        );
      });
    })
  });
});