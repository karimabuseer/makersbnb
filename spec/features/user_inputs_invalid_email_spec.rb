feature 'invalid email' do 
  scenario 'tests for a invalid email' do
    visit('/sign_up')
    fill_in('name', with: 'Test')
    fill_in('email', with: 'thisisnotanemail')
    fill_in('password', with: 'Password1!')
    click_button('Sign Up')
    expect(page).to have_content("Please enter a valid email")
  end 
end
