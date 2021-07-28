require 'pg'


def database_connection
  ENV['RACK_ENV'] == 'test' ?
  (PG.connect dbname: 'makersbnb_test') : (PG.connect dbname: 'makersbnb')
end

