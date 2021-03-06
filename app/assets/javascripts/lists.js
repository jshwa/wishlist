HandlebarsIntl.registerWith(Handlebars);
Handlebars.registerHelper('display_rating', function(stars) {
  var rating = ""
  for (let i = 0; i < stars; i++) {
    rating += "<i class='fa fa-star' aria-hidden='true'></i>"
  }
  return rating
})

function listReviews() {
  $(document).on('click','.js-wishlist-review-btn', function(e){
    e.preventDefault();
    var source = $('#wishlist-reviews-template').html();
    var template = Handlebars.compile(source);
    var reviewsDiv = $(`#gift-${this.dataset.id}-reviews`);
    if ($('.reviews_title', reviewsDiv).length === 0){
      $.getJSON(this.action).done(function(reviews){
        reviewsDiv.append(template(reviews)).slideDown();
      })} else {
        reviewsDiv.slideUp().empty();
      };
  });
}

function removeGift() {
  $(document).on('submit','.js-remove-btn', function(e){
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

function editWishlistDesc() {
  $(document).on('click', '#js-edit-btn', function(e){
    e.preventDefault();
    $.getScript($(this).attr('href'))
  })
}

function startWriting() {
  $(document).on('submit', '.js-welcome-btn', function(e) {
    e.preventDefault();
    $.getScript(this.action)
  })
}

$(function(){
  listReviews();
  removeGift();
  editWishlistDesc();
  startWriting();
})
