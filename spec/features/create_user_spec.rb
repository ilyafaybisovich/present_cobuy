feature 'a new user can sign up' do
  scenario 'user can see homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Prezzy!'
  end

  context 'when not signed in' do
    scenario 'user should see sign in and sign up buttons' do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    scenario 'user should not see sign out button' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'when user is signed in and on the home page' do
    before do
      user_signup
    end

    scenario 'user should not see sign in or sign up buttons' do
      visit '/'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end

    scenario 'user should see sign out button' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    scenario 'user should be able to sign out and back in again' do
      visit '/'
      click_link 'Sign out'
      user_signin
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
      expect(page).to have_link 'Sign out'
    end
  end
end
