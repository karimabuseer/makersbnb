require 'user'
require 'pg'
require 'bcrypt'
require_relative 'database_helpers'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Test', email: 'test@example.co.uk', password: 'password')
      persisted_data = persisted_data(table: 'users', user_id: user.user_id)

      expect(user).to be_a User
      expect(user.name).to eq 'Test'
      expect(user.user_id).to eq(persisted_data[0]['user_id'])
      expect(user.email).to eq 'test@example.co.uk'
    end

    it 'scrambles the password' do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create(name: 'Test', email: 'test@example.co.uk', password: 'password123')
    end
  end
end
