ALTER TABLE listings ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id);