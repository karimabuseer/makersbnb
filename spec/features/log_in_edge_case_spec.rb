feature 'log in edge cases' do
  scenario 'redirected to login when email not found' do
    visit '/log_in'
    fill_in('email', with: 'j')
    fill_in('password', with: 'j')
    click_button('Submit')
    expect(current_path).to eq('/log_in')
    expect(page).to have_content('Your email and password do not match')
  end
end