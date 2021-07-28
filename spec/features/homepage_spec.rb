feature 'homepage' do 
  scenario "homepage contains fields and login" do
    visit('/')
    expect(page).to have_button("Log In")
    expect(page).to have_field("name")
    expect(page).to have_field("email")
    expect(page).to have_field("password")
  end
end