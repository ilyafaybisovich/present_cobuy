feature 'showing user page' do
  context 'when user is not signed in' do
    xscenario 'user cannot see active prezzies button' do
      expect(page).not_to have_link 'View active prezzies'
    end
  end

  context 'when user is signed in' do
    before do
      user_signup
    end

    xscenario 'user can see active prezzies button' do
      expect(page).to have_link 'View active prezzies'
    end

    xscenario 'before the prezzy is created' do
      click_link 'View active prezzies'
      expect(page).to have_content 'Not contributing to any prezzies'
    end

    xscenario 'once a prezzy is created', js: true do
      create_prezzy
      wait_for_ajax
      visit '/'
      click_link 'View active prezzies'
      expect(page).to have_link 'History of Liversedge'
      click_link 'History of Liversedge'
      expect(page).to have_content 'History of Liversedge'
    end

    xscenario 'can see two prezzies', js: true do
      create_prezzy
      wait_for_ajax
      visit '/'
      create_prezzy 'History of Leeds'
      wait_for_ajax
      visit '/'
      click_link 'View active prezzies'
      expect(page).to have_link 'History of Liversedge'
      expect(page).to have_link 'History of Leeds'
      click_link 'History of Liversedge'
      expect(page).to have_content 'History of Liversedge'
      expect(page).not_to have_content 'History of Leeds'
    end
  end

  # context 'when added as a contributor', js: true, focus: true do
  #   before do
  #     proxy.stub('/gifts/search')
  #       .and_return(json: FORMATTED_RETURN)
  #     user_signup
  #     visit '/'
  #     click_link 'Sign out'
  #     user_signup 'user2@prezzy.ie'
  #     visit '/gifts/new'
  #     fill_in 'Title', with: 'Jade’s Graduation'
  #     fill_in 'Recipient', with: 'Jade'
  #     fill_in 'Recipient address', with: 'Somewhere'
  #     fill_in 'Delivery date', with: '29/05/2015'
  #     fill_in 'search_keyword', with: 'Linux'
  #     click_button 'Search'
  #     wait_for_ajax
  #     find("#products").click_button("product_3")
  #     wait_for_ajax
  #     click_link 'Add a contributor'
  #     fill_in 'Email', with: 'test@prezzy.ie'
  #     click_button 'Create gift'
  #     visit '/'
  #     click_link 'Sign out'
  #     user_signin
  #   end
  #
  #   xxscenario 'user can see prezzies that someone else has added them to' do
  #     expect(page).to have_link 'Jade’s Graduation'
  #   end
  # end
end
