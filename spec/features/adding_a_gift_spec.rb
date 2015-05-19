require 'rails_helper'

feature 'adds a gift' do
  context 'searching for an amazon product' do
    scenario 'fetch product from amazon' do
      proxy.stub('/gift/search')
        .and_return(jsonp: [{ title: 'Macbook Pro', asin: 'hfducehfuhg378', image: '/image', price: 300.70 }])
      visit '/gift/new'
      click_button('Search')
      expect(page).to have_content('Macbook Pro')
    end
  end
end