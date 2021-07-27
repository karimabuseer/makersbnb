feature 'Logging out' do
  scenario 'A user can log out' do
    sign_up
    click_button('Log Out')

    expect(current_path).to eq('/')
    expect(page).to have_content 'You have logged out.'
  end
end
