function attachReviewListeners() {
  $('.js-list-review-btn').on('click', function(e){
    e.preventDefault();
    let id = $(this).attr('data-id');
    $.getJSON(this.action).done(function(reviews){
      $.each(reviews.data, function(key, review){
        $(`#gift-${id}-reviews`).append(review.attributes.comment);
      });
    });
  });
}

$(function(){
  attachReviewListeners();
})
