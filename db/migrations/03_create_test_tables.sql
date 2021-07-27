-- testdb --
CREATE TABLE users(user_id SERIAL PRIMARY KEY, name VARCHAR(50), email VARCHAR(90), password VARCHAR(20));
CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, name VARCHAR(40), blurb VARCHAR(450), price INT, user_id INT);
ALTER TABLE listings ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);