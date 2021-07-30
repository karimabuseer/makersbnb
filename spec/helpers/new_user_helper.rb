def new_user
  User.create(name: 'Test', email: 'test@example.co.uk', password: 'password')
end