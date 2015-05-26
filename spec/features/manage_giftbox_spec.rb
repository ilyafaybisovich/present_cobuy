require 'helpers/session_helper'

feature 'Manage Giftbox', js: true do
  background do
    user_signup
    gift = Gift.create title: "Mum's Birthday",
                       recipient: "Mary",
                       recipient_address: '15 Ada House, E2 2BB',
                       delivery_date: '2015-06-15',
                       item: '12345',
                       item_price: 600.0,
                       description: 'MacBook Pro',
                       item_image: 'http://prezzy.com/macbook.jpg',
                       item_url: 'http://amazon.co.uk/macbook',
                       user_id: 1
    gift.contributors.create gift_id: 1, email: 'contributor1@giftbox.ie'
    visit '/gifts/1'
  end

  context 'Organiser creates a gift –' do

    scenario 'organiser sees the giftbox title' do
      expect(page).to have_content "Mum's Birthday"
    end

    scenario 'organiser sees the delivery address' do
      expect(page).to have_content '15 Ada House, E2 2BB'
    end

    scenario 'organiser sees the item title' do
      expect(page).to have_content 'MacBook Pro'
    end

    scenario 'organiser sees the item cost split between contributors' do
      gift = Gift.first
      gift.contributors.create gift_id: 1, email: 'contributor2@giftbox.ie'
      visit '/gifts/1'
      expect(page).to have_content '£300.00 to Pay'
      expect(page).not_to have_content 'Paid'
    end

    scenario 'organiser sees the item image' do
      expect(page).to have_xpath '//img'
    end

    scenario 'organiser sees all contributors' do
      expect(page).to have_content 'user1@giftbox.ie'
      expect(page).to have_content 'contributor1@giftbox.ie'
    end

    scenario 'organiser sees a progress bar' do
      expect(page).to have_css '.progress-bar'
      expect(page).to have_css '.progress-bar[style="width:0%"]'
      expect(page).to have_content '0%'
    end
  end

  context 'Contributors make payments –' do
    scenario 'progress bar at 0% before any payments' do
      expect(page).to have_css '.progress-bar[style="width:0%"]'
      expect(page.find('div.progress-bar').text).to eq '0%'
    end

    scenario 'progress bar updates on payment', focus: true do
      page.find('.stripe-button-el').click
      stripe = all('iframe[name=stripe_checkout_app]').last
      page.within_frame stripe do
        fill_in 'email', with: 'test@test.com'
        fill_in 'card_number', with: '4242 4242 4242 4242'
        fill_in 'cc-exp', with: '12/18'
        fill_in 'cc-csc', with: '123'
        page.find('#submitButton').click
      end
      sleep 5
      expect(page).to have_content '100%'
      expect(page).to have_content 'Paid'
      expect(page).not_to have_css '.stripe-button-el'
    end
  end
end
