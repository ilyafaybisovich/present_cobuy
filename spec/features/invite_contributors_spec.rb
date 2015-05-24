feature 'Invite Contributors' do
  context 'user is signed in' do
    before do
      user_signup 'contributor1@prezzy.ie'
      click_link 'Sign out'
      user_signup
    end
# There is no way of telling this on the page, it needs to be tested from the gifts/:id page - Rob
    # scenario 'organiser is automatically added', focus: true do
    #   visit '/gifts/new'
    #   expect(page).to have_field 'gift[user_id]'
    # end

    scenario 'user can see the button to add contributors' do
      visit '/gifts/new'
      expect(page).to have_link 'Add a contributor'
    end

    context 'add and remove', js: true do
      before do
        visit '/gifts/new'
        click_link 'Add a contributor'
      end

      scenario 'one contributor can be added' do
        expect(page).to have_css '.add_contributor'
        expect(page).to have_link 'Remove this contributor'
      end

      scenario 'contributor can be removed' do
        click_link 'Remove this contributor'
        expect(page).not_to have_link 'Remove this contributor'
      end

      scenario 'more than one contributor can be added' do
        click_link 'Add a contributor'
        expect(page).to have_css '.remove_contributor', count: 2
      end
    end
  end
end
