require 'pg'
require_relative 'connection'

class Listing

  attr_reader :listing_id, :name, :description, :price, :user_id
  
  def initialize(listing_id:, name:, description:, price:, user_id:)
    @listing_id = listing_id
    @name = name
    @description = description
    @price = price  
    @user_id = user_id
  end


  def self.all

    result = database_connection.exec("SELECT * FROM listings;")

    result.map do |listing|
      Listing.new(
        listing_id: listing['listing_id'],
        name: listing['name'],
        description: listing['description'],
        price: listing['price'],
        user_id: listing['user_id']
      )
    end
  end

  def self.create(name:, description:, price:, user_id:)
    result = database_connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('#{name.gsub("'","''")}', '#{description.gsub("'","''")}', '#{price}',#{user_id} ) 
                                      RETURNING listing_id;")
    Listing.new(
      listing_id: result[0]['listing_id'], 
      name: name, 
      description: description, 
      price: price,
      user_id: user_id
    )

  end

  def self.find_by_listing_id(listing_id:)
  
    result = database_connection.exec("SELECT * FROM listings WHERE listing_id = '#{listing_id}'")
    
    Listing.new(
      listing_id: result[0]['listing_id'], 
      name: result[0]['name'], 
      description: result[0]['description'], 
      price: result[0]['price'],
      user_id: result[0]['user_id'])

  end
end

