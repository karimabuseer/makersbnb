# Makersbnb
Week 5 group project for Makers.
This is a web app to list and book spaces.

## Setting up the project
1. Clone this repo
2. Run bundle in your terminal
3. Create a production database and a test database (we recommend the names 'makersbnb' & 'makersbnb_test')
4. Connect to each database and run the commands in db/migrations/ in order

## User stories

```
As a host
So I can advertise spaces								
I would like to post ‘spaces’ (with id, name, short description and price per night)
```
```
As a guest
So I can find a place to stay		
I would like to view a list of spaces
```
```
As a host
So I post a space as my own
I want to sign up for an account
```
```
As a host
So only I can post my own space	
I want to sign in to my account
```
```
As a host
So I can avoid others posting as me		
I want to sign out of my account
```
```
As a guest
So I can request a space as myself			
I want to sign up for/log in to/log out of an account
```
```
As a guest
So I can see what’s available to me			
I want to see available dates for each space
```
```
As a guest
So I can stay in a space
I want to request an available space
```
```
As a host
So a guest can stay in my space
I want to confirm a request
```
```
As a host
So I don’t disappoint guests
I want my space’s availability to change when a booking is confirmed
```

## Extra features
1. Email and password validations for signing up and logging in
2. Listings searchable by date and name
3. Secure password using BCrypt
4. Dealing with edge cases for username and password


## CRC cards
![Cards mapping MVP objects](https://github.com/karimabuseer/makersbnb/blob/main/docs/Screenshot%202021-07-26%20at%2015.04.58.png)

## Database Structure
![Database Structure](https://github.com/karimabuseer/makersbnb/blob/main/docs/Screenshot%202021-07-26%20at%2015.29.33.png)
