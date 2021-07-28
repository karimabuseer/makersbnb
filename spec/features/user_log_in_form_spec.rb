feature 'Log in form' do
  scenario 'User can enter their details to log in' do
    sign_up
    click_button('Log Out')
    log_in

    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome Test!')
  end
end
