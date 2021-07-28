feature 'View listings' do
  scenario 'A user can see listings' do
    Listing.create(name: 'pavs hotel', description: 'swamp', price: 10)
    Listing.create(name: 'sens cesspit', description: 'super swampy', price: 5)

    visit '/listings'

     expect(page).to have_content('pavs hotel')
     expect(page).to have_content('sens cesspit')
     expect(page).to have_content('swamp')
     expect(page).to have_content('super swampy')
     expect(page).to have_content('10')
     expect(page).to have_content('5')
    end
  end