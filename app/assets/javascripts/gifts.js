function loaddata(data){
  if(jQuery.isEmptyObject(data)) {
    $('#products').hide();
    $(".amazon_error p").text("No Products Found");
  } else {
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
  // =================== amazon search ==============================
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
        $(".amazon_error p").text("No Response from Amazon. Try Again.");
      }
    });
  });

  // =================== select product 1 ==============================
  $('#product_1').click(function(){
    $('#gift_item').val($('#product-asin-1').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--1').text()));
    $('#gift_description').val($('.product__title--1').text());
    $('#gift_item_url').val($('.product__link--1').attr("href"));
    $('#gift_item_image').val($('.product__image--1').attr("src"));
    $('.added').text('Added a Gift: '+ $('.product__title--1').text());
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    });
  });
  // =================== select product 2 ==============================
  $('#product_2').click(function(){
    $('#gift_item').val($('#product-asin-2').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--2').text()));
    $('#gift_description').val($('.product__title--2').text());
    $('#gift_item_url').val($('.product__link--2').attr("href"));
    $('#gift_item_image').val($('.product__image--2').attr("src"));
    $('.added').text('Added a Gift: '+ $('.product__title--2').text());
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    });
  });
  // =================== select product 3 ==============================
  $('#product_3').click(function(){
    $('#gift_item').val($('#product-asin-3').text());
    $('#gift_item_price').val(currencyToFloat($('.product__price--3').text()));
    $('#gift_description').val($('.product__title--3').text());
    $('#gift_item_url').val($('.product__link--3').attr("href"));
    $('#gift_item_image').val($('.product__image--3').attr("src"));
    $('.added').text('Added a Gift: '+ $('.product__title--3').text());
    $('#products').fadeOut(200, function(){
      $('.added').fadeIn(400);
    });
  });
    // =================== Zinc.io POST call ==============================
  $('#purchase').click(function(){
    $.ajax({
      type: 'POST',
      url: 'https://api.zinc.io/v0/order',
      data: JSON.stringify(zincData),
      success: function(data){
        $.ajax({
          type:'POST',
          url: 'https://api.zinc.io/v0/order/' + data.request_id,
          success: function(data){
            console.log(data)
          }
        });
      },
      error: function(data){
        console.log("error");
        console.log(data);
      }
    });
  });
});

var zincData = {
  "client_token": "public",
  "retailer": "amazon",
  "products": [{"product_id": "0923568964", "quantity": 1}],
  "max_price": 0,
  "shipping_address": {
    "first_name": "Tim",
    "last_name": "Beaver",
    "address_line1": "77 Massachusetts Avenue",
    "address_line2": "",
    "zip_code": "02139",
    "city": "Cambridge",
    "state": "MA",
    "country": "US",
    "phone_number": "5551230101"
  },
  "is_gift": true,
  "gift_message": "Heres your package, Tim! Enjoy!",
  "shipping_method": "cheapest",
  "payment_method": {
    "name_on_card": "Ben Bitdiddle",
    "number": "5555555555554444",
    "security_code": "123",
    "expiration_month": 1,
    "expiration_year": 2015,
    "use_gift": false
  },
  "billing_address": {
    "first_name": "William",
    "last_name": "Rogers",
    "address_line1": "84 Massachusetts Ave",
    "address_line2": "",
    "zip_code": "02139",
    "city": "Cambridge",
    "state": "MA",
    "country": "US",
    "phone_number": "5551234567"
  },
  "retailer_credentials": {
    "email": "timbeaver@gmail.com",
    "password": "myRetailerPassword"
  },
  "webhooks": {
    "order_placed": "http://mywebsite.com/zinc/order_placed",
    "order_failed": "http://mywebsite.com/zinc/order_failed",
    "tracking_obtained": "http://mywebsite.com/zinc/tracking_obtained"
  },
  "client_notes": {
    "our_internal_order_id": "abc123"
  }
}
