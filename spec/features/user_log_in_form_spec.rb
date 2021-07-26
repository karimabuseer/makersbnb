feature 'Log in form' do
  scenario 'User can enter their details to log in' do
    visit('/log_in')
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'test_pa55word')
    click_button('Submit')

    expect(current_path).to eq('/')
    expect(page).to have_content('Welcome test@email.com!')
  end
end