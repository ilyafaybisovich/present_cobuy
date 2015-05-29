function loaddata(data){
  if(jQuery.isEmptyObject(data)) {
    $('#products').hide();
    $(".amazon_error p").text("No Products Found");
  } else {
    $(".amazon_error p").text("");
    $('#products').fadeIn(200);
    for(var i = 0; i < 3; i++) {
      $('.product__title--' + (i+1)).text(data[i].title);
      $('.product__link--' + (i+1)).attr("href", data[i].url_path);
      $('.product__image--' + (i+1)).attr("src", data[i].image);
      $('.product__price--' + (i+1)).text(data[i].price);
      $('#product-asin-' + (i+1)).text(data[i].asin);
      if(data[i].price === "") { $('#product_' + (i+1)).hide(); }
    }
  }
}

function currencyToFloat(currency){
  return parseFloat(currency.substr(1));
}

$(document).ready(function(){
  // if($('#paid').is(':contains("to Pay")').css('color', '#FA2282');
  $('.payment:contains("Paid")').each(function() {
    $(this).removeClass("to-pay");
    $(this).addClass("paid");
  });
  //   var ourText = $(this);
  //   if(ourText.match('£25.02 to Pay')) {
  //     $(this).css('color', 'red');
  //   };
  // });
  // $('#paid .entry').each(function() {
  //  if($(this).is(':contains("to Pay")')) {
  //       $(this).css('color', 'red');
  //   }
  // });

  //=================== ajax spinner ==============================
    $('#loadingDiv').hide();  // Hide it initially
    $(document).ajaxStart(function() {
          $('#loadingDiv').show();
      });
    $(document).ajaxStop(function() {
          $('#loadingDiv').hide();
      });

  // =================== amazon search ==============================
  $('#amazon_search').click('page:load', function(event){
    event.preventDefault();
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
        $(".amazon_error p").text("No Response from Amazon. Try Again.");
      }
    });
  });

  $('#search_keyword').keypress(function(event){
    if(event.which == 13) {
      event.preventDefault();
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
          $(".amazon_error p").text("No Response from Amazon. Try Again.");
        }
      });
    }
  });

  // =================== select product 1 ==============================
  $('#product_1').click(function(event){
    event.preventDefault();
    $('#gift_item').val($('#product-asin-1').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--1').text()));
    $('#gift_description').val($('.product__title--1').text());
    $('#gift_item_url').val($('.product__link--1').attr("href"));
    $('#gift_item_image').val($('.product__image--1').attr("src"));
    $('.added').html('<h4>Gift added:</h4><h3>' + $('.product__title--1').text()) + '</h3>';
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    $('#create-gift').removeClass('hidden');

    });
  });
  // =================== select product 2 ==============================
  $('#product_2').click(function(event){
    event.preventDefault();
    $('#gift_item').val($('#product-asin-2').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--2').text()));
    $('#gift_description').val($('.product__title--2').text());
    $('#gift_item_url').val($('.product__link--2').attr("href"));
    $('#gift_item_image').val($('.product__image--2').attr("src"));
    $('.added').html('<h4>Gift added:</h4><h3>' + $('.product__title--1').text()) + '</h3>';
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    $('#create-gift').removeClass('hidden');
    });
  });
  // =================== select product 3 ==============================
  $('#product_3').click(function(event){
    event.preventDefault();
    $('#gift_item').val($('#product-asin-3').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--3').text()));
    $('#gift_description').val($('.product__title--3').text());
    $('#gift_item_url').val($('.product__link--3').attr("href"));
    $('#gift_item_image').val($('.product__image--3').attr("src"));
    $('.added').html('<h4>Gift added:</h4><h3>' + $('.product__title--1').text()) + '</h3>';
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    $('#create-gift').removeClass('hidden');
    });
  });
});
