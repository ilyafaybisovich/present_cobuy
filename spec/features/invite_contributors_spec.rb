require 'delay_helper'

feature 'Invite Contributors' do
  context 'when logged in and with a prezzy being made' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
      prepare_prezzy
    end

    scenario 'user can invite contributors', :js => true do
      visit '/gifts/new'
      click_button 'Add contributors'
      wait_for_ajax
      expect(page).to have_css('#contributor_1[name="contributor_email"]')
    end
  end
end
