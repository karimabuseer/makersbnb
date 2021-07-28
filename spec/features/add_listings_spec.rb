feature 'add-listings' do
  scenario 'user can add a listing' do
    visit('/listings')

    click_button('Add listing')

    expect(current_path).to eq('/listings/add')

  end

end