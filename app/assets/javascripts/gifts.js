function loaddata(data){
  if(jQuery.isEmptyObject(data)) {
    $('#products').hide();
    $(".amazon_error p").text("No Products Found");
  } else {
    $('#products').show();
    for(var i = 0; i < 3; i++) {
      $('.product__title--' + (i+1)).text(data[i].title);
      $('.product__link--' + (i+1)).attr("href", data[i].url_path);
      $('.product__image--' + (i+1)).attr("src", data[i].image);
      $('.product__price--' + (i+1)).text(data[i].price);
    }
  };
}

$(document).ready(function(){
  $('#amazon_search').click(function(){   
    $.ajax({
      type: 'GET',
      url: "/gifts/search",
      data: {
        keyword: $('#search_keyword').val()
      },
      success: function(data){
        loaddata(data);
      },
      error: function(){
        $(".amazon_error p").text("No Response from Amazon. Try Again.")
      }
    });
  });
});