feature 'Logging out' do
  scenario 'A user can log out' do
    visit('/log_in')
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'test_pa55word')
    click_button('Submit')
    click_button('Log Out')

    expect(current_path).to eq('/')
    expect(page).to have_content 'You have logged out.'
  end
end
