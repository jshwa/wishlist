HandlebarsIntl.registerWith(Handlebars);
Handlebars.registerHelper('display_rating', function(stars) {
  var rating = ""
  for (let i = 0; i < stars; i++) {
    rating += "<i class='fa fa-star' aria-hidden='true'></i>"
  }
  return rating
})

function listReviews() {
  var source = $('#wishlist-reviews-template').html();
  var template = Handlebars.compile(source);

  $('.js-wishlist-review-btn').on('click', function(e){
    e.preventDefault();
    var reviewsDiv = $(`#gift-${this.dataset.id}-reviews`);
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

function removeGift() {
  $('.js-remove-btn').on('submit', function(e){
    e.preventDefault();
    var giftDiv = $(`#gift-${this.dataset.id}`);
    $.ajax({
      url: this.action,
      method: "DELETE",
      data: $(this).serialize(),
      dataType: "json"
    }).done(function(msg){
      giftDiv.slideUp(function(){
        giftDiv.remove()});
    });
  });
}

$(function(){
  listReviews();
  removeGift();
})
