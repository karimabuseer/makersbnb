require 'pg'

def persisted_data(table:, user_id:)
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.query("SELECT * FROM #{table} WHERE user_id = '#{user_id}';")
end
