require 'helpers/mock_helper'

def create_prezzy title = 'History of Liversedge',
                  recipient = 'Joe',
                  address = '1 Station Parade, Liversedge',
                  delivery_date = '15/06/2015',
                  search_term = 'macbook pro'
  proxy.stub('/gifts/search')
    .and_return(json: FORMATTED_RETURN)
  visit '/gifts/new'
  fill_in 'Title', with: title
  fill_in 'Recipient', with: recipient
  fill_in 'Recipient address', with: address
  fill_in 'Delivery date', with: delivery_date
  fill_in 'search_keyword', with: search_term
  click_button 'Search'
  wait_for_ajax
  find("#products").click_button("product_1")
  wait_for_ajax
  click_button 'Create gift'
end
