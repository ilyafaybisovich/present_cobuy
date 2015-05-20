require 'rails_helper'
require 'mock_helper'

feature 'adds a gift', js: true do
  context 'searching for an amazon product' do
    scenario 'fetch product from amazon' do
      proxy.stub('/gifts/search')
        .and_return(json: FORMATTED_RETURN)
      visit '/gifts/new'
      fill_in 'search_keyword', with: 'Macbook Pro'
      click_button('Search')
      expect(page).to have_content('MacBook Pro')
    end

    scenario 'no product returned from amazon' do
      # proxy.stub('/gifts/search')
      #   .and_return(json: FORMATTED_RETURN)
      visit '/gifts/new'
      fill_in 'search_keyword', with: 'fejiowfjFwjeopfjewfjP'
      click_button('Search')
      expect(page).to have_content('No Products Found')
    end
  end
end
