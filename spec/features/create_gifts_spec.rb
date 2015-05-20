feature 'create gifts' do
  context 'when user is not signed in' do
    scenario 'user cannot create a gift' do
      visit '/'
      expect(page).not_to have_link 'Create gift'
    end
  end

  context 'when user is signed in' do
    before do
      user_signup
    end

    scenario 'user can see the create gift link' do
      visit '/'
      expect(page).to have_link 'Create gift'
    end

    scenario 'user can create a gift' do
      visit '/'
      click_link 'Create gift'
      expect(page).to have_button 'Add contributors'
      expect(page).not_to have_css('input[id="contributor_1"]')
      fill_in 'Title', with: 'History of Liversedge'
      fill_in 'Recipient', with: 'Joe'
      fill_in 'Recipient address', with: '1 Station Parade, Liversedge'
      fill_in 'Delivery date', with: '15th June'
      click_button 'Create gift'
      expect(page).to have_content 'History of Liversedge'
    end
  end
end
