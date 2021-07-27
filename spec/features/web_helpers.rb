def log_in
  visit('/log_in')
  fill_in('email', with: 'test@email.com')
  fill_in('password', with: 'test_pa55word')
  click_button('Submit')
end
