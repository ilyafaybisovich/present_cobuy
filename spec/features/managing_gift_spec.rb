feature 'managing a gift', js: true do
  context 'gift displays on loading page' do
    before do
      gift = Gift.create(title: "Mum's birthday",
                         recipient: "Mary",
                         recipient_address: '15 Ada House, E2 2BB',
                         delivery_date: 'June 15',
                         item: '12345',
                         item_price: '£750',
                         description: 'MacBook Pro',
                         split_price: '£110',
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
      expect(page).to have_content '£110'
    end

    scenario 'page to have an item image' do
      expect(page).to have_xpath '//img'
    end

    scenario 'page to have a contributor' do
      expect(page).to have_content 'test@test.com'
    end
  end
end