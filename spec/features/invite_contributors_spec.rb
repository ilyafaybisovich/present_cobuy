feature 'Invite Contributors' do
  context 'when logged in and with a prezzy being made' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
      prepare_prezzy
    end

    scenario 'add a contributor' do
      visit '/gifts/new'
      fill_in 'contributor_email', with: 'contributor@prezzy.ie'
      click_button 'Add contributor'
      expect(page).to have_content 'contributor@prezzy.ie'
    end
  end
end
