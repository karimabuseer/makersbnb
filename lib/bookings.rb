require 'pg'
require 'bcrypt'
require_relative './connection.rb'

class Booking

  attr_reader :booking_id, :confirmed, :start_date, :end_date, :listing_id, :user_id

  def initialize(booking_id:, confirmed:, start_date:, end_date:, listing_id:, user_id:)
    @booking_id = booking_id
    @confirmed = confirmed
    @start_date = start_date
    @end_date = end_date
    @listing_id = listing_id
    @user_id = user_id
  end

  def self.all

    bookings = database_connection.exec("SELECT * FROM bookings;")

    bookings.map do |booking|
      Booking.new(
        booking_id: booking['booking_id'],
        confirmed: booking['confirmed'],
        start_date: booking['start_date'],
        end_date: booking['end_date'],
        listing_id: booking['listing_id'],
        user_id: booking['user_id']
        )
    
    end
  end

  def self.outgoing_bookings(user_id:)
    bookings = database_connection.exec("SELECT * FROM bookings WHERE user_id=#{user_id};")
    
    bookings.map do |booking|
      Booking.new(
        booking_id: booking['booking_id'],
        confirmed: booking['confirmed'],
        start_date: booking['start_date'],
        end_date: booking['end_date'],
        listing_id: booking['listing_id'],
        user_id: booking['user_id']
        )
      end
    end

    def self.incoming_bookings(user_id:)
      bookings = database_connection.exec("SELECT * FROM bookings WHERE listing_id IN (SELECT listing_id FROM listings WHERE user_id=#{user_id});")
      
      bookings.map do |booking|
        Booking.new(
          booking_id: booking['booking_id'],
          confirmed: booking['confirmed'],
          start_date: booking['start_date'],
          end_date: booking['end_date'],
          listing_id: booking['listing_id'],
          user_id: booking['user_id']
          )
      end
    end
  
  def self.create(start_date:, end_date:, listing_id:, user_id:)
    booking = database_connection.exec("INSERT INTO bookings (start_date, end_date, listing_id, user_id) 
                                        VALUES ('#{start_date}', '#{end_date}', '#{listing_id}', '#{user_id}') 
                                        RETURNING booking_id, confirmed;")

    Booking.new( 
      booking_id: booking[0]['booking_id'],
      confirmed: booking[0]['confirmed'],
      start_date: start_date, 
      end_date: end_date, 
      listing_id: listing_id, 
      user_id: user_id)
  end

  def self.find_by_booking_id(booking_id:)
    booking = database_connection.exec("SELECT * FROM bookings WHERE booking_id = '#{booking_id}'")

    Booking.new(
      booking_id: booking[0]['booking_id'], 
      confirmed: booking[0]['confirmed'], 
      start_date: booking[0]['start_date'],
      end_date: booking[0]['end_date'],
      listing_id: booking[0]['listing_id'], 
      user_id: booking[0]['user_id'])
  end

  def self.reject_if_booked(listing_id:, start_date:, end_date:, booking_id:)
    database_connection.exec("UPDATE bookings SET confirmed = FALSE WHERE listing_id = '#{listing_id}'
      AND start_date = '#{start_date}' AND end_date = '#{end_date}' AND booking_id != '#{booking_id}'")
  end

  def accept_booking
    database_connection.exec("UPDATE bookings SET confirmed = TRUE WHERE booking_id = '#{booking_id}'")
    Booking.reject_if_booked(listing_id: listing_id, start_date: start_date, end_date: end_date, booking_id: booking_id)
    confirm_booking
  end

  def deny_booking
    database_connection.exec("UPDATE bookings SET confirmed = FALSE WHERE booking_id = '#{booking_id}'")
    reject_booking
  end

  def self.existing_booking(start_date:, end_date:, listing_id:)
    result = database_connection.exec("SELECT * FROM bookings WHERE confirmed = true AND start_date = '#{start_date}' 
                    AND end_date = '#{end_date}' AND listing_id = '#{listing_id}' ").first
    result ? true : false
  end

  private

  def confirm_booking
    @confirmed = true
  end

  def reject_booking
    @confirmed = false
  end

end