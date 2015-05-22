feature 'managing a gift', js: true do
  context 'gift displays on loading page' do
    before do
      gift = Gift.create(title: "Mum's birthday",
                         recipient: "Mary",
                         recipient_address: '15 Ada House, E2 2BB',
                         delivery_date: 'June 15',
                         item: '12345',
                         item_price: 750.0,
                         description: 'MacBook Pro',
                         item_image: 'http://prezzy.com/macbook.jpg',
                         item_url: 'http://amazon.co.uk/macbook'
                        )
      gift.contributors.create(gift_id: 1,
                               email: 'test@test.com'
                              )
      visit '/gifts/1'
    end

    scenario 'page to have a title' do
      expect(page).to have_content "Mum's birthday"
    end

    scenario 'page to have a delivery address' do
      expect(page).to have_content '15 Ada House, E2 2BB'
    end

    scenario 'page to have a item title' do
      expect(page).to have_content 'MacBook Pro'
    end

    scenario 'page to have a split cost' do
      gift = Gift.first
      gift.contributors.create(gift_id: 1,
                               email: 'test2@test.com'
                              )
      visit '/gifts/1'
      expect(page).to have_content '375'
    end

    scenario 'page to have an item image' do
      expect(page).to have_xpath '//img'
    end

    scenario 'page to have a contributor' do
      expect(page).to have_content 'test@test.com'
    end

    scenario 'page to have a progress bar' do
      expect(page).to have_css('.progress-bar')
      expect(page).to have_css('.progress-bar[style="width:70%"]')
      expect(page).to have_content '70%'
    end
  end
end