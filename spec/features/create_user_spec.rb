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
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'sample@something.ie'
      fill_in 'Password', with: 'moomoocow'
      fill_in 'Password confirmation', with: 'moomoocow'
      click_button 'Sign up'
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
  end
end
