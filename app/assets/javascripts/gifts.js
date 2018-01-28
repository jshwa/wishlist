function Gift(attributes) {
  this.id = attributes.id;
  this.name = attributes.name;
  this.price = attributes.price;
  this.image = attributes.image;
  this.price = attributes.price;
}

function addGiftForm() {
  $(document).on('click', '#new-gift', function(e){
    e.preventDefault();
    $.getScript($(this).attr('href')).done(createGift())
  })
}

function createGift(){
  $(document).on('submit', 'form#new_gift', function(e) {
    e.preventDefault();
    $.post(this.action, $(this).serialize(), displayNewGift, 'json')
  })
}

function displayNewGift(json) {
  var gift = new Gift(json)
  debugger
}

$(function(){
  addGiftForm();
})
