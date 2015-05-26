require 'session_helper'
require 'mock_helper'
require 'wait_for_ajax_helper'

feature 'Amazon Search' do
  context 'When user is not signed in –' do
    scenario 'user cannot search for an Amazon product' do
      visit '/gifts/new'
      expect(page).not_to have_content 'Search for a gift'
      expect(page).not_to have_field 'search_keyword'
      expect(page).not_to have_button 'Search'
    end
  end

  context 'When signed in and on the giftbox creation page –' do
    before do
      user_signup
      visit '/gifts/new'
    end

    scenario 'user sees the product search form' do
      expect(page).to have_content 'Search for a gift'
      expect(page).to have_field 'search_keyword'
      expect(page).to have_button 'Search'
    end

    scenario 'user searches for a valid product on Amazon', js: true do
      proxy.stub('/gifts/search').and_return json: FORMATTED_RETURN
      fill_in 'search_keyword', with: 'MacBook Pro'
      click_button 'Search'
      wait_for_ajax
      expect(page).to have_content 'MacBook'
    end

    scenario 'user searches for an invalid product on Amazon', js: true do
      proxy.stub('/gifts/search').and_return json: FORMATTED_RETURN
      fill_in 'search_keyword', with: 'fejiowfjFwjeopfjewfjP'
      click_button 'Search'
      wait_for_ajax
      expect(page).to have_content 'No Products Found'
      expect(page).not_to have_content 'MacBook'
    end

    scenario 'user selects a product for the giftbox', js: true do
      proxy.stub('/gifts/search').and_return json: FORMATTED_RETURN
      fill_in 'search_keyword', with: 'Macbook Pro'
      click_button 'Search'
      wait_for_ajax
      click_button 'product_1'
      wait_for_ajax
      expect(page).to have_content 'Added a gift:'
    end

    context 'before performing a search –' do
      scenario 'user cannot see any Amazon products' do
        expect(page).not_to have_content 'MacBook'
      end
    end
  end
end
