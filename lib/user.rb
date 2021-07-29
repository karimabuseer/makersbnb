require 'pg'
require 'bcrypt'
require_relative 'connection'


class User 

  attr_reader :user_id, :name, :email

  def initialize(user_id:, name:, email:)
    @user_id = user_id
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = database_connection.exec("INSERT INTO users (name, email, password) VALUES ('#{name.gsub("'", "''")}', '#{email}', '#{encrypted_password}') RETURNING user_id, name, email, password;")
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'])
  end

  def self.find(email)
    return nil unless email

    result = database_connection.exec("SELECT * FROM users WHERE email = '#{email}';")
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    result = database_connection.exec("SELECT * FROM users WHERE email = '#{email}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'])
  end
end
