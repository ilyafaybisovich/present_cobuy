require 'mock_helper'

DEFAULT_TITLE = 'Joe’s Stag Do'
DEFAULT_RECIPIENT = 'Joe'
DEFAULT_SHIP_NAME = 'Dave'
DEFAULT_SHIP_SURNAME = 'Smith'
DEFAULT_SHIP_ADD1 = '12 Main Street'
DEFAULT_SHIP_CITY = 'Dunroamin'
DEFAULT_SHIP_PCODE = 'AB12 3CD'
DEFAULT_DATE = '16/05/2027'
DEFAULT_SEARCH = 'russian standard'
DEFAULT_CONTRIBUTORS = []
DEFAULT_GIFTBOX = {
  title: DEFAULT_TITLE,
  recipient: DEFAULT_RECIPIENT,
  ship_name: DEFAULT_SHIP_NAME,
  ship_surname: DEFAULT_SHIP_SURNAME,
  ship_add1: DEFAULT_SHIP_ADD1,
  ship_city: DEFAULT_SHIP_CITY,
  ship_pcode: DEFAULT_SHIP_PCODE,
  delivery_date: DEFAULT_DATE,
  search_term: DEFAULT_SEARCH,
  contributors: DEFAULT_CONTRIBUTORS
}

def create_giftbox giftbox_hash = DEFAULT_GIFTBOX
  prepare_giftbox giftbox_hash
  find('input[type="submit"]').trigger 'click'
end

def prepare_giftbox giftbox_hash = DEFAULT_GIFTBOX
  proxy.stub('/gifts/search').and_return(json: FORMATTED_RETURN)
  visit '/gifts/new'
  fill_in_fields giftbox_hash
  select_product
  add_contributors giftbox_hash[:contributors]
end

private

def fill_in_fields giftbox_hash
  fill_in 'Occasion', with: giftbox_hash[:title]
  fill_in 'Recipient', with: giftbox_hash[:recipient]
  fill_in 'Delivery date', with: giftbox_hash[:delivery_date]
  fill_in 'Name', with: giftbox_hash[:ship_name]
  fill_in 'Surname', with: giftbox_hash[:ship_surname]
  fill_in 'Address', with: giftbox_hash[:ship_add1]
  fill_in 'City', with: giftbox_hash[:ship_city]
  fill_in 'Postcode', with: giftbox_hash[:ship_pcode]
  fill_in 'search_keyword', with: giftbox_hash[:search_term]
end

def select_product
  click_button 'Search'
  wait_for_ajax
  find('#products').click_button 'product_1'
  wait_for_ajax
end

def add_contributors contributors
  contributors.each do |contributor|
    find('.add_contributor').trigger 'click'
    all(:css, 'div.nested-fields input[type="email"]').last.set contributor
  end
end
