require 'mock_helper'

feature 'adds a gift', js: true do
  context 'searching for an amazon product' do
    before do
      user_signup
      visit '/gifts/new'
    end

    scenario 'fetch product from amazon' do
      proxy.stub('/gifts/search')
        .and_return(json: FORMATTED_RETURN)
      fill_in 'search_keyword', with: 'Macbook Pro'
      click_button('Search')
      wait_for_ajax
      expect(page).to have_content('MacBook Pro')
    end

    scenario 'no product returned from amazon' do
      proxy.stub('/gifts/search')
        .and_return(json: FORMATTED_RETURN)
      fill_in 'search_keyword', with: 'fejiowfjFwjeopfjewfjP'
      click_button('Search')
      wait_for_ajax
      expect(page).to have_content('No Products Found')
      expect(page).not_to have_content('MacBook')
    end

    scenario 'can select a product for the gift' do
      proxy.stub('/gifts/search')
        .and_return(json: FORMATTED_RETURN)
      fill_in 'search_keyword', with: 'Macbook Pro'
      click_button('Search')
      wait_for_ajax
      click_button("product_1")
      wait_for_ajax
      expect(page).to have_content('Added a Gift:')
    end
  end

  context 'before a search' do
    scenario 'does not display products' do
      expect(page).not_to have_content 'A Product Title'
    end
  end
end
