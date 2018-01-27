HandlebarsIntl.registerWith(Handlebars);

function attachReviewListeners() {
  var source = $('#wishlist-reviews-template').html();
  var template = Handlebars.compile(source);

  $('.js-wishlist-review-btn').on('click', function(e){
    e.preventDefault();
    var id = this.dataset.id;
    var reviewsDiv = $(`#gift-${id}-reviews`);
    if ($('.reviews_title', reviewsDiv).length === 0){
      $.getJSON(this.action).done(function(reviews){
        reviewsDiv.append('<h2 class="reviews_title"> Reviews: </h2>');
        if (!reviews[""]) {
          reviewsDiv.append(template(reviews)).slideDown();
        } else {
          reviewsDiv.append("Nothing here...").slideDown();
        }
      })} else {
        reviewsDiv.slideUp().empty();
      };
  });
}

$(function(){
  attachReviewListeners();
})
