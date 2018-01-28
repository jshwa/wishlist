function addGiftForm() {
  $(document).on('click', '#new-gift', function(e){
    e.preventDefault();
    $.getScript($(this).attr('href')).done(function(resp){
      createGift();
    })
  })
}



$(function(){
  addGiftForm();
})
