require 'bookings'
require 'listing'

describe Booking do

  describe '.create' do
    it 'should create a new booking' do  
      listing = Listing.create( 
        name: "sens hotel", 
        description: "castle", 
        price: "100")
      
      user = User.create(
        name: 'sen',
        email: 'banana@bread.com', 
        password: 'banana')

      booking = Booking.create(
        start_date: '2021-10-10',
        end_date: '2021-11-12',
        user_id: user.user_id,
        listing_id: listing.listing_id)
        

      expect(booking.start_date).to eq('2021-10-10')
      expect(booking.end_date).to eq('2021-11-12')
      expect(booking.listing_id).to eq(listing.listing_id)
      expect(booking.user_id).to eq(user.user_id)
      
    end
  end


  describe '.find_by_booking_id' do
    it 'should find a booking obj' do
      listing = Listing.create( 
        name: "sens hotel", 
        description: "castle", 
        price: "100")
      
      user = User.create(
        name: 'sen',
        email: 'banana@bread.com', 
        password: 'banana')

      booking = Booking.create(
        start_date: '2021-10-10',
        end_date: '2021-11-12',
        user_id: user.user_id,
        listing_id: listing.listing_id)

      booking_id = Booking.find_by_booking_id(booking_id: booking.booking_id)

      expect(booking_id.start_date).to eq('2021-10-10')
      expect(booking.end_date).to eq('2021-11-12')
      expect(booking.listing_id).to eq(listing.listing_id)
      expect(booking.user_id).to eq(user.user_id)
      expect(booking_id.confirmed).to be_nil
    end
  end
end

#   describe '.outgoing_bookings' do
#     it 'should return the bookings for specified user' do

#       listing = Listing.create( 
#         name: "sens hotel", 
#         description: "castle", 
#         price: "100")
      
#       user = User.create(
#         name: 'sen',
#         email: 'banana@bread.com', 
#         password: 'banana')

#       booking_1 = Booking.create(start_date: '2021-10-12', end_date: '2021-11-12', listing_id: listing['listing_id'], user_id: user['user_id'] )

#     end
# end
