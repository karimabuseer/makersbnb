feature 'homepage' do 
  scenario do
    visit('/')
    expect(page).to have_button("Log In")
    # page.find_button('Log In')[:value]
    expect(page).to have_field("name")
    expect(page).to have_field("email")
    expect(page).to have_field("password")
  end
end