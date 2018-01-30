function showCategory() {
  $(document).on('click', '.category-link', function(e) {
    e.preventDefault();
    var source = $('#category-template').html();
    var template = Handlebars.compile(source);
    $.getJSON($(this).attr('href')).done(function(resp){
      $('#show-category').html(template(resp))
    })
  })
}


$(function(){
  showCategory();
})
