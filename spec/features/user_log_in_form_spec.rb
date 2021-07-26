feature 'Log in form' do
  scenario 'User can enter their details to log in' do
    log_in

    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome test@email.com!')
  end
end