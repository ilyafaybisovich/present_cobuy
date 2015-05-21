feature 'Invite Contributors' do
  context 'when logged in and with a prezzy being made' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
      prepare_prezzy
    end

    scenario 'user can invite 1 contributor', js: true do
      visit '/gifts/new'
      click_button 'Add contributors'
      expect(page).to have_css 'input#contributor_1'
      expect(page).not_to have_css 'input#contributor_2'
    end

    scenario 'user can invite 2 contributors', js: true do
      visit '/gifts/new'
      click_button 'Add contributors'
      expect(page).to have_css 'input#contributor_1'
      click_button 'Add contributors'
      expect(page).to have_css 'input#contributor_2'
    end
  end
end
