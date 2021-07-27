require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Test', email: 'test@example.co.uk', password: 'password')
      expect(user.name).to eq 'Test'
      expect(user.email).to eq 'test@example.co.uk'
    end
  end
end
