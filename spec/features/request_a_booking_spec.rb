feature 'Requesting a booking' do
  scenario 'it produces a request' do
    User.create(name: 'Host', email: 'host@email.com', password: 'password')
    visit('/log_in')
    fill_in('email', with: 'host@email.com')
    fill_in('password', with: 'password')
    click_button('Submit')
    create_listing
    click_button('Log Out')
    User.create(name: 'Guest', email: 'test@example.com', password: 'password')
    log_in
    book_first_listing
    expect(page).to have_content('really nice')
    expect(page).to have_content('10')
    expect(page).to have_content('Not confirmed')
    expect(page).to have_content('2020-11-05')
    expect(page).to have_content('2020-11-10')
  end
end
