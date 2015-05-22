require 'mock_helper'

feature 'create gifts', js: true do
  context 'when user is not signed in' do
    scenario 'user cannot create a gift via homepage' do
      visit '/'
      expect(page).not_to have_link 'Create gift'
    end

    scenario 'user cannot create a gift via URL' do
      visit '/gifts/new'
      expect(page).not_to have_button 'Create gift'
      expect(page).to have_content 'Please sign in to create a gift'
    end
  end

  context 'when user is signed in' do
    before do
      user_signup
    end

    scenario 'user can see the create gift link' do
      visit '/'
      expect(page).to have_link 'Create gift'
    end

    scenario 'user can create a gift', js: true do
      title = 'History of Liversedge'
      recipient = 'Joe'
      address = '1 Station Parade, Liversedge'
      delivery_date = '15/06/2015'
      search_term = 'macbook pro'
      # Capybara.default_wait_time = 5
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
      expect(page).to have_content 'History of Liversedge'
      expect(page).to have_content 'Joe'
      expect(page).to have_content '1 Station Parade, Liversedge'
      expect(page).to have_content '2015-06-15'
      expect(page).to have_content 'test@prezzy.ie'
    end

    xscenario 'ensure organiser is also a contributor'
  end
end
