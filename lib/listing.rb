require 'pg'
require_relative './connection.rb'

class Listing

  attr_reader :listing_id, :name, :description, :price
  
  def initialize(listing_id:, name:, description:, price:)
    @listing_id = listing_id
    @name = name
    @description = description
    @price = price

  end


  def self.all

    listing = database_connection.exec("SELECT * FROM listings;")

    listing.map do |listing|
      Listing.new(
        listing_id: listing['listing_id'],
        name: listing['name'],
        description: listing['description'],
        price: listing['price']
      )
    end
  end

  def self.create(name:, description:, price:)
    listing = database_connection.exec("INSERT INTO listings (name, description, price) VALUES('#{name}', '#{description}', '#{price}') 
                                      RETURNING listing_id;")
    Listing.new(
      listing_id: listing[0]['listing_id'], 
      name: name, 
      description: description, 
      price: price)
  end

  def self.find_by_listing_id(listing_id:)
  
    listing = database_connection.exec("SELECT * FROM listings WHERE listing_id = '#{listing_id}'")
    
    Listing.new(
      listing_id: listing[0]['listing_id'], 
      name: listing[0]['name'], 
      description: listing[0]['description'], 
      price: listing[0]['price'])

  end
end
