
feature 'Viewing a listing page' do
  scenario 'it can be accessed via the listings page' do
    create_listing
    first('.listings').click_button 'View'
    listingid = Listing.all[0].listing_id
    expect(current_path).to eq("/listings/#{listingid}")
    expect(page).to have_content 'Castle'
    expect(page).to have_content 'really nice'
    expect(page).to have_content '10'
  end

  scenario 'It shows selected booking dates' do
    create_listing
    first('.listings').click_button 'View'
    fill_in('start', with: '2020-11-05')
    fill_in('end', with: '2020-11-10')
    click_button('Request to book')

    # expect current path
    expect(page).to have_content '2020-11-05'
    expect(page).to have_content '2020-11-10'
  end
end
