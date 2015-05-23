def user_signup email = 'test@prezzy.ie', password = 'moomoocow'
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def create_prezzy title = 'History of Liversedge',
                  recipient = 'Joe',
                  address = '1 Station Parade, Liversedge',
                  delivery_date = '15/06/2015',
                  search_term = 'macbook pro'
  visit '/'
  click_link 'Create gift'
  fill_in 'Title', with: title
  fill_in 'Recipient', with: recipient
  fill_in 'Recipient address', with: address
  fill_in 'Delivery date', with: delivery_date
  fill_in 'search_keyword', with: search_term
  click_button 'Search'
  click_button 'product_1'
  click_button 'Create gift'
end
