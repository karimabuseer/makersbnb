def log_in
  visit('/log_in')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'password')
  click_button('Submit')
end

def sign_up
  visit('/sign_up')
  fill_in('name', with: 'Test')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'password')
  click_button('Sign Up')
end
