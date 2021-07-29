feature 'invalid password' do 
  scenario 'tests for a invalid password' do
    visit('/sign_up')
    fill_in('name', with: 'Test')
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'password')
    click_button('Sign Up')
    expect(page).to have_content("Please enter a valid password")

  end 
end
