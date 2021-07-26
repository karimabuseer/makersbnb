feature 'Signing up' do
  scenario 'A user can sign up' do
    visit('/sign_up')
    fill_in('name', with: 'Test')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password')
    click_button('Sign Up')

    expect(current_path).to eq('/')
    expect(page).to have_content 'Welcome Test!'
  end
end
