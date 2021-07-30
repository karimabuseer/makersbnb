feature 'add-listings' do
  context 'when user is logged in' do
    scenario 'user can add a listing' do
      sign_up
      visit('/listings')
      click_button('Add listing')

      expect(current_path).to eq('/listings/add')
    end
  end

  context 'when user is not logged in' do
    scenario 'user is redirected to log in page when they try to add listing' do
      visit('/listings')
      click_button('Add listing')

      expect(current_path).to eq('/log_in')
      expect(page).to have_content('You must be logged in to do that.')
    end
  end
end