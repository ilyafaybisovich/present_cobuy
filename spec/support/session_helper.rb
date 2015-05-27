DEFAULT_EMAIL = 'user1@giftbox.ie'
DEFAULT_NAME = 'xOxOaMyRuLeZoXoX'
DEFAULT_PASSWORD = 'moomoocow'

def user_signup email = DEFAULT_EMAIL, name = DEFAULT_NAME,
                                       password = DEFAULT_PASSWORD
  visit '/users/sign_up'
  fill_in 'Email', with: email
  fill_in 'Name', with: name
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def user_signin email = DEFAULT_EMAIL, password = DEFAULT_PASSWORD
  visit '/'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end
