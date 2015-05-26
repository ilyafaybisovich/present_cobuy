require 'session_helper'

feature 'User Session' do
  context 'When not signed in –' do
    context 'visitor navigates to the home page –' do
      background { visit '/' }

      scenario 'visitor sees tag-line, sign in form and sign up button' do
        expect(page).to have_content(
          'Make present headaches a thing of the past'
        )
        expect(page).to have_css 'div.user_sign_in'
        expect(page).to have_link 'Sign up'
      end

      scenario 'visitor cannot see sign out button' do
        expect(page).not_to have_content 'Sign out'
      end

      scenario 'visitor can navigate to sign up page' do
        find('.sign-up-button').click
        expect(page).to have_content 'Sign up'
        expect(page).to have_css 'div.user_sign_up'
      end
    end

    context 'visitor navigates to the sign up page –' do
      background { visit '/users/sign_up' }

      scenario 'visitor signs up' do
        user_signup
        expect(page).to have_content 'Welcome! You have signed up successfully.'
      end
    end

    context 'previous user signs in –' do
      background do
        user_signup
        click_link 'Sign out'
      end

      scenario 'user signs back in' do
        user_signin
        expect(page).to have_content 'Signed in successfully.'
      end
    end
  end

  context 'When signed in –' do
    background { user_signup }

    context 'user navigates to the home page –' do
      background { visit '/' }

      scenario 'user cannot see sign in form or sign up button' do
        expect(page).not_to have_css 'div.user_sign_in'
        expect(page).not_to have_link 'Sign up'
      end

      scenario 'user sees sign out button' do
        expect(page).to have_link 'Sign out'
      end

      scenario 'user can sign out and see visitor’s home page' do
        click_link 'Sign out'
        expect(page).to have_content 'Signed out successfully.'
        expect(page).to have_content(
          'Make present headaches a thing of the past'
        )
        expect(page).to have_css 'div.user_sign_in'
        expect(page).to have_link 'Sign up'
      end
    end
  end
end
