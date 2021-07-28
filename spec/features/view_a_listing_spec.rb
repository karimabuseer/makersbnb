

feature 'Viewing a listing page' do
  scenario 'it can be accessed via the listings page' do
    visit('/listings')
    click_button('Add listing')
    fill_in('name', with: 'Castle')
    fill_in('description', with:'really nice')
    fill_in('price', with: '10' )
    click_button('List my space')
    first('.listings').click_button 'View'
    listingid = Listing.all[0].listing_id
    expect(current_path).to eq("listings/#{listingid}")
  end
end