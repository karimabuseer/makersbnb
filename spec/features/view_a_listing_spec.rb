
feature 'Viewing a listing page' do
  scenario 'it can be accessed via the listings page' do
    sign_up
    create_listing
    first('.listings').click_button 'View'
    listingid = Listing.all[0].listing_id
    expect(current_path).to eq("/listings/#{listingid}")
    expect(page).to have_content 'Castle'
    expect(page).to have_content 'really nice'
    expect(page).to have_content '10'
  end

  scenario 'It shows selected booking dates' do
    sign_up
    create_listing
    book_first_listing
    # expect current path
    expect(page).to have_content '2020-11-05'
    expect(page).to have_content '2020-11-10'
  end
end
