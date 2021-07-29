feature 'navigation' do
  scenario 'navigation contains listings' do
    visit('/')
    expect(page).to have_button("Listings")
  end
end