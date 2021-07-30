require 'user'
require 'pg'
require 'bcrypt'
require_relative '../helpers/database_helpers'

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

  describe '.find' do
    it 'finds a user by email' do
      user = User.create(name: 'Test', email: 'test@example.co.uk', password: 'password')
      result = User.find('test@example.co.uk')

      expect(result).to be_a(User)
      expect(result.user_id).to eq(user.user_id)
      expect(result.name).to eq(user.name)
    end
    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end


  describe '.authenticate' do
    it 'returns a user given the right name and password' do
      user = User.create(name: 'Test', email: 'test@example.com', password: 'password123')
      auth_user = User.authenticate(email: 'test@example.com', password: 'password123')

      expect(auth_user.user_id).to eq user.user_id
    end
    it 'returns nil if email doesnt exist' do
      User.create(name: 'Test', email: 'test@example.com', password: 'password123')
      expect(User.authenticate(email: 'wrongemail@email.com', password:'password')).to eq nil
    end

    it 'returns nil if password is wrong' do
      User.create(name: 'Test', email: 'test@example.com', password: 'password123')
      expect(User.authenticate(email: 'example@example.com', password:'wrongpassword')).to eq nil
    end
  end
end
