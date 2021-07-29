require 'listing'
require_relative '../helpers/new_user_helper'

describe Listing do

  describe '.all' do
    it 'should display all listings' do
      
      connection = PG.connect(dbname: 'makersbnb_test')

      listing = Listing.create(name: 'pavs hotel', description: 'swamp', price: 10, user_id: new_user.user_id)

      Listing.create(name: 'sens hotel', description: 'castle', price: 100, user_id: new_user.user_id)

      listings = Listing.all

      expect(listings.length).to eq 2 
      expect(listings.first).to be_a Listing 
      expect(listings.first.name).to eq "pavs hotel"
      expect(listings.first.description).to eq "swamp"
      expect(listings.first.price).to eq "10"

    end
  end

  describe '.create' do
    it 'should create a new listing' do

    listing = Listing.create(name: 'pavs hotel', description: 'swamp', price: 10, user_id: new_user.user_id)

    expect(Listing.all.length).to eq 1
      expect(listing).to be_a Listing 
      expect(listing.name).to eq "pavs hotel"
      expect(listing.description).to eq "swamp"
      expect(listing.price).to eq 10
    end
  end

  describe '.find_by_listing_id' do
    it 'should find the listing created' do
      listing = Listing.create(name: 'pavs hotel', description: 'swamp', price: 10, user_id: new_user.user_id )

      result = Listing.find_by_listing_id(listing_id: listing.listing_id)

      expect(result).to be_a Listing
      expect(result.listing_id).to eq listing.listing_id
      expect(result.name).to eq 'pavs hotel'
      expect(result.description).to eq 'swamp'
      expect(result.price).to eq "10"
    end
  end

end