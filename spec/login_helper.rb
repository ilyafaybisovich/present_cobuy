def user_signup email = 'sample@something.ie', password = 'moomoocow'
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
                  delivery_date = '15th June'
  visit '/'
  click_link 'Create gift'
  fill_in 'Title', with: title
  fill_in 'Recipient', with: recipient
  fill_in 'Recipient address', with: address
  fill_in 'Delivery date', with: delivery_date
  click_button 'Create gift'
end
