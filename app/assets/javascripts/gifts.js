function addGiftForm() {
  $(document).on('click', '#new-gift', function(e){
    e.preventDefault();
    $.getScript($(this).attr('href')).done(createGift())
  })
}

function createGift(){
  $(document).on('submit', 'form#new_gift', function(e) {
    e.preventDefault();
    $.post(this.action, $(this).serialize(), displayNewGift, 'json');
  })
}

function Gift(attributes) {
  this.id = attributes.id;
  this.name = attributes.name;
  this.price = attributes.price;
  this.image = attributes.image;
  this.price = attributes.price;
  this.url = attributes.url;
}

Gift.addTemplates = function() {
  Gift.templateSource = $('#gift-card-template').html();
  Gift.template = Handlebars.compile(Gift.templateSource);
}

Gift.prototype.renderCard = function() {
  return Gift.template(this);
}

function displayNewGift(json) {
  Gift.addTemplates();
  var gift = new Gift(json.gift);
  var giftCard = gift.renderCard();
  $('.gift_list').append(giftCard);
  $('.new_gift_container').slideUp().remove();
}

$(function(){
  addGiftForm();
})
