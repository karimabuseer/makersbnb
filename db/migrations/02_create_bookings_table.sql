CREATE TABLE bookings (booking_id SERIAL PRIMARY KEY, confirmed BOOLEAN, 
    start_date date, end_date date, listing_id int references listings(listing_id),
                                                          user_id int references users(user_id));