def log_in
  visit('/log_in')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'Password1!')
  click_button('Submit')
end

def sign_up
  visit('/sign_up')
  fill_in('name', with: 'Test')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'Password1!')
  click_button('Sign Up')
end

def create_listing
  visit('/listings')
  click_button('Add listing')
  fill_in('name', with: 'Castle')
  fill_in('description', with:'really nice')
  fill_in('price', with: '10' )
  click_button('List my space')
end

def book_first_listing
  first('.listings').click_button 'View'
  fill_in('start', with: '2020-11-05')
  fill_in('end', with: '2020-11-10')
  click_button('Request to book')
end
