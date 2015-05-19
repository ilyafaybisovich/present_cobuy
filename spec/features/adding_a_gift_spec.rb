require 'rails_helper'
require 'mock_helper'

feature 'adds a gift', js: true do
  context 'searching for an amazon product' do
    xscenario 'fetch product from amazon' do
      proxy.stub('/gift/search')
        .and_return(jsonp: FORMATTED_RETURN)
      visit '/gifts/new'
      click_button('Search')
      expect(page).to have_content('Macbook Pro')
    end
  end
end
