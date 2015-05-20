feature 'Invite Contributors' do
  context 'when logged in and with a prezzy being made' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
      prepare_prezzy
    end

    scenario 'user can invite contributors' do
      click_link 'Add contributors'
      expect(page).to have_content 'Contributors'
      expect(page).to have_content 'contributor1@prezzy.ie'
    end
  end
end
