require 'rails_helper'

feature 'a new user can sign up' do
  scenario 'user can see homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Prezzy!'
  end
end
