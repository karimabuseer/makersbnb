feature 'add-listings' do
  scenario 'user can add a listing' do
    visit('/makersbnb/listings')

    click_button('Add listing')

    expect(current_path).to eq('/makersbnb/listings/add')

  end

end