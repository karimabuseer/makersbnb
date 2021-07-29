feature 'Signing up' do
  scenario 'A user can sign up' do
    sign_up

    expect(current_path).to eq('/listings')
    expect(page).to have_content 'Welcome Test!'
  end
end
