feature 'managing a gift', js: true do
    before do
      user_signup
      gift = Gift.create(title: "Mum's birthday",
                         recipient: "Mary",
                         recipient_address: '15 Ada House, E2 2BB',
                         delivery_date: 'June 15',
                         item: '12345',
                         item_price: 600.0,
                         description: 'MacBook Pro',
                         item_image: 'http://prezzy.com/macbook.jpg',
                         item_url: 'http://amazon.co.uk/macbook',
                         user_id: 1
                        )
      gift.contributors.create(gift_id: 1,
                               email: 'test@test.com'
                              )
      visit '/gifts/1'
    end

  context 'gift displays on loading page' do

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
      p Gift.first
      p Gift.first.contributors
      visit '/gifts/1'
      expect(page).to have_xpath('//input[@value="Pay £300.00"]')
    end

    scenario 'page to have an item image' do
      expect(page).to have_xpath '//img'
    end

    scenario 'page to have a contributor' do
      expect(page).to have_content 'test@test.com'
    end

    scenario 'page to have a progress bar' do
      expect(page).to have_css('.progress-bar')
      expect(page).to have_css('.progress-bar[style="width:0%"]')
      expect(page).to have_content '0%'
    end
  end

  context 'contributors make payment' do
    scenario 'progress bar at 0% before any payments' do
      expect(page).to have_css('.progress-bar[style="width:0%"]')
      expect(page.find('div.progress-bar').text).to eq '0%'
    end
    scenario 'progress bar updates on payment' do
      click_button('Pay £600.00')
      expect(page).to have_content('100%')
    end
  end
end