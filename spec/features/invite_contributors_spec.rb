feature 'Invite Contributors' do
  context 'user is signed in' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
    end

    scenario 'user can see the create gift page' do
      visit '/gifts/new'
      expect(page).to have_link 'Add a contributor'
    end

    context 'add', js: true do
      before do
        visit '/gifts/new'
        click_link 'Add a contributor'
      end

      scenario 'one contributor' do
        expect(page).to have_css('input#add_contributor')
        expect(page).to have_link 'Remove this contributor'
      end

      scenario 'more than one contributor' do
        click_link 'Add a contributor'
        expect(page).to have_css('input[type="email"]', :count => 2)
        expect(page).to have_css('a[class="remove_nested_fields"]', :count => 2)
      end
    end
  end
end
