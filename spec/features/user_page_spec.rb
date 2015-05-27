require 'support/session_helper'
require 'support/giftbox_creation_helper'
require 'support/wait_for_ajax_helper'

feature 'User Page' do
  context 'When user is not signed in –' do
    scenario 'user cannot see any profile page' do
      visit '/'
      expect(page).not_to have_link 'View account'
      user_signup
      click_link 'Sign out'
      visit '/users/1'
      expect(page).not_to have_content '@giftbox.ie'
      expect(page).to have_content 'Please sign in to see your profile'
      visit '/users/1582'
      expect(page).not_to have_content '@giftbox.ie'
      expect(page).to have_content 'Please sign in to see your profile'
    end
  end

  context 'When user is signed in –' do
    background { user_signup }

    scenario 'user sees a button to view their profile' do
      expect(page).to have_link 'View profile'
    end

    scenario 'user cannot see anyone else’s profiles' do
      visit '/users/1582'
      expect(page).to have_content 'You cannot view other people’s profiles'
    end

    context 'user navigates to their profile page –' do
      background { click_link 'View profile' }

      scenario 'user sees their username' do
        expect(page).to have_content 'xOxOaMyRuLeZoXoX'
      end

      scenario 'user sees their email address' do
        expect(page).to have_content 'user1@giftbox.ie'
      end

      scenario 'user sees an empty list if '\
        'they are not contributing to anything' do
        expect(page).to have_content 'Not contributing to any giftboxes'
        expect(page).not_to have_link 'Joe’s Stag Do'
      end
    end

    context 'user creates a giftbox –', js: true do
      background do
        create_giftbox
        wait_for_ajax
      end

      scenario 'user sees giftbox on profile page after creation' do
        sleep 1
        click_link 'View profile'
        expect(page).to have_link 'Joe’s Stag Do'
        click_link 'Joe’s Stag Do'
        expect(page).to have_content 'Joe’s Stag Do'
      end

      scenario 'user sees two giftboxes on profile page' do
        giftbox_details = {
          title: 'Jade’s Graduation',
          recipient: 'Jade',
          address: '4 Station Drive, Gudnes Nowes',
          delivery_date: '29/05/2015',
          search_term: 'rainbow beanie',
          contributors: [
            'gus@giftbox.ie',
            'dan@giftbox.ie',
            'ici@giftbox.ie',
            'ilya@giftbox.ie',
            'joe@giftbox.ie',
            'mark@giftbox.ie',
            'rob@giftbox.ie',
            'sam@giftbox.ie',
            'dave@giftbox.ie',
            'jord@giftbox.ie'
          ]
        }
        create_giftbox giftbox_details
        wait_for_ajax
        sleep 1
        click_link 'View profile'
        expect(page).to have_link 'Joe’s Stag Do'
        expect(page).to have_link 'Jade’s Graduation'
        click_link 'Joe’s Stag Do'
        expect(page).to have_content 'Joe’s Stag Do'
        expect(page).not_to have_content 'Jade’s Graduation'
      end
    end
  end

  context 'When added as a contributor by another user –', js: true do
    background do
      user_signup
    end

    scenario 'user sees giftboxes they were added to before signing up' do
      giftbox_details = DEFAULT_GIFTBOX
      giftbox_details[:contributors] = ['user2@giftbox.ie']
      create_giftbox giftbox_details
      click_link 'Sign out'
      user_signup 'user2@giftbox.ie'
      click_link 'View profile'
      expect(page).to have_link 'Joe’s Stag Do'
    end

    scenario 'user sees giftboxes they can contribute to but did not create' do
      click_link 'Sign out'
      user_signup 'user2@giftbox.ie'
      giftbox_details = DEFAULT_GIFTBOX
      giftbox_details[:contributors] = ['user1@giftbox.ie']
      create_giftbox giftbox_details
      click_link 'Sign out'
      user_signin
      expect(page).to have_link 'Joe’s Stag Do'
    end
  end
end
