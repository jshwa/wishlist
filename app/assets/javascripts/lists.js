function attachReviewListeners() {
  $('.js-wishlist-review-btn').on('click', function(e){
    e.preventDefault();
    var id = $(this).attr('data-id');
    var source = $('#wishlist-reviews-template').html();
    var template = Handlebars.compile(source);
    $(`#gift-${id}-reviews`).append('<h2 class="reviews_title"> Reviews: </h2>');
    $.getJSON(this.action).done(function(response){
      $.each(response, function(index, review){
        $(`#gift-${id}-reviews`).append(template(review))
      });
    });
  });
}

$(function(){
  attachReviewListeners();
})
