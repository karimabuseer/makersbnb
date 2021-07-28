feature 'homepage' do 
  scenario do
    visit('/')
    expect(page).to have_link("Login", :href => "/log_in")
    expect(page).to have_field("name")
    expect(page).to have_field("email")
    expect(page).to have_field("password")
  end
end