require 'pg'
require 'connection.rb'

describe '.database_connection' do
  it 'it returns first value in users table' do
    database_connection.exec("INSERT INTO users (name) VALUES('James');")
    database = database_connection.exec 'SELECT * FROM users;'
    expect(database[0]['name']).to eq 'James'
  end
end

