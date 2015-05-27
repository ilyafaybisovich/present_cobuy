require 'support/session_helper'
require 'support/giftbox_creation_helper'
require 'support/wait_for_ajax_helper'

feature 'Create Giftbox' do
  context 'When user is not signed in –' do
    scenario 'user cannot create a giftbox' do
      visit '/'
      expect(page).not_to have_link 'Create a giftbox'
      visit '/gifts/new'
      expect(page).not_to have_button 'Create giftbox'
      expect(page).to have_content 'Please sign in to create a giftbox'
    end
  end

  context 'When user is signed in –' do
    background { user_signup }

    scenario 'user sees button to create a giftbox' do
      expect(page).to have_link 'Create a giftbox'
    end

    scenario 'user can navigate to the giftbox creation page' do
      click_link 'Create a giftbox'
      expect(page).to have_content 'Create a giftbox'
      expect(page).to have_css 'form#new_gift'
    end

    context 'user navigates to the giftbox creation page –' do
      background { visit '/gifts/new' }

      scenario 'user can create a giftbox', js: true do
        create_giftbox
        wait_for_ajax
        expect(page).to have_content 'Joe’s Stag Do'
        expect(page).to have_content 'Joe'
        expect(page).to have_content '12 Main Street, Dunroamin'
        expect(page).to have_content '2027-05-16'
        expect(page).to have_css 'p#organiser', text: 'user1@giftbox.ie'
      end

      scenario 'organiser is also a contributor', js: true do
        create_giftbox
        wait_for_ajax
        expect(page).to have_css 'div#contributors', text: 'user1@giftbox.ie'
      end

      scenario 'additional contributors can be added to giftbox', js: true do
        giftbox_hash = DEFAULT_GIFTBOX
        giftbox_hash[:contributors] =
          %w(contributor1@giftbox.ie contributor2@giftbox.ie)
        create_giftbox giftbox_hash
        wait_for_ajax
        expect(page).to have_content 'contributor1@giftbox.ie'
        expect(page).to have_content 'contributor2@giftbox.ie'
      end

      scenario 'contributors can be removed from giftbox', js: true do
        giftbox_hash = DEFAULT_GIFTBOX
        giftbox_hash[:contributors] =
          %w(mistake@giftbox.ie contributor2@giftbox.ie)
        prepare_giftbox giftbox_hash
        first('div.nested-fields a').trigger 'click'
        click_button 'Create a giftbox'
        wait_for_ajax
        expect(page).not_to have_content 'mistake@giftbox.ie'
        expect(page).to have_content 'contributor2@giftbox.ie'
      end
    end
  end
end
