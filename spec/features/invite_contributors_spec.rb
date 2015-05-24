feature 'Invite Contributors' do
  context 'user is signed in' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
    end

    xscenario 'user can see the button to add contributors' do
      visit '/gifts/new'
      expect(page).to have_link 'Add a contributor'
    end

  context 'add and remove', js: true do
      before do
        visit '/gifts/new'
        click_link 'Add a contributor'
      end

      xscenario 'one contributor can be added' do
        expect(page).to have_css '.add_contributor'
        expect(page).to have_link 'Remove this contributor'
      end

      xscenario 'contributor can be removed' do
        click_link 'Remove this contributor'
        expect(page).not_to have_link 'Remove this contributor'
      end

      xscenario 'more than one contributor can be added' do
        click_link 'Add a contributor'
        expect(page).to have_css '.remove_contributor', count: 2
      end
    end
  end
end
