require 'bookings'
require 'listing'

describe Booking do

  describe '.create' do
    it 'should create a new booking' do 

      user = User.create(
        name: 'sen',
        email: 'banana@bread.com', 
        password: 'banana')

      listing = Listing.create( 
        name: "sens hotel", 
        description: "castle", 
        price: "100",
        user_id: user.user_id)

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
      
      user = User.create(
        name: 'sen',
        email: 'banana@bread.com', 
        password: 'banana')

      listing = Listing.create( 
        name: "sens hotel", 
        description: "castle", 
        price: "100",
        user_id: user.user_id
      )

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

  describe '.outgoing_bookings' do
    it 'should return the all bookings requested by guest' do

      user = User.create(
        name: 'sen',
        email: 'banana@bread.com', 
        password: 'banana')

      listing = Listing.create( 
        name: "sens hotel", 
        description: "castle", 
        price: "100",
        user_id: user.user_id)

      booking_1 = Booking.create(
        start_date: '2021-10-12', 
        end_date: '2021-11-12', 
        listing_id: listing.listing_id, 
        user_id: user.user_id
       )

       booking_2 = Booking.create(
        start_date: '2021-11-02', 
        end_date: '2021-12-02', 
        listing_id: listing.listing_id, 
        user_id: user.user_id
       )

       booking_3 = Booking.create(
        start_date: '2021-08-11', 
        end_date: '2021-09-16', 
        listing_id: listing.listing_id, 
        user_id: user.user_id
       )

       outgoing_bookings = Booking.outgoing_bookings(user_id: user.user_id)

      expect(outgoing_bookings.length).to eq(3)
      expect(outgoing_bookings.first).to be_a(Booking)
      expect(outgoing_bookings.first.user_id).to eq(booking_1.user_id)
      expect(outgoing_bookings.first.start_date).to eq('2021-10-12')
      expect(outgoing_bookings.first.end_date).to eq('2021-11-12')
      expect(outgoing_bookings.first.listing_id).to eq(listing.listing_id)
      expect(outgoing_bookings.first.user_id).to eq(user.user_id)
    end
end

describe '.incoming_bookings' do
  it 'return all requests for the listing owned by host' do

    user = User.create(
      name: 'sen',
      email: 'banana@bread.com', 
      password: 'banana')

    listing = Listing.create( 
      name: "sens hotel", 
      description: "castle", 
      price: "100",
      user_id: user.user_id)

    booking_1 = Booking.create(
      start_date: '2021-10-12', 
      end_date: '2021-11-12', 
      listing_id: listing.listing_id, 
      user_id: user.user_id
    )

      incoming_bookings = Booking.incoming_bookings(user_id: user.user_id)

      expect(incoming_bookings.length).to eq(1)
      expect(incoming_bookings.first.user_id).to eq(booking_1.user_id)
      expect(incoming_bookings.first.confirmed).to be_nil
      expect(incoming_bookings.first.start_date).to eq('2021-10-12')
      expect(incoming_bookings.first.end_date).to eq('2021-11-12')
    end
  end

end