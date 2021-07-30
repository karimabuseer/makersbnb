require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'pg'
require 'bcrypt'
require './lib/user'
require_relative './lib/listing'
require_relative './lib/bookings'
require_relative './lib/details'

class MakersBnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/listings' do
    @listings = Listing.all
    erb :'/listings/index'
  end

  get '/listings/add' do
    erb :'/listings/add'
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price: params[:price], user_id: session[:user].user_id)
    redirect '/listings'
  end

  get '/listings/:listing_id' do
    @listing = Listing.find_by_listing_id(listing_id: params[:listing_id])
    erb :'/listings/book'
  end

  get '/sign_up' do
    erb :"users/sign_up"
  end

  post '/user' do
    unless Details.authenticate_email(params[:email])
      flash[:notice] = "Please enter a valid email"
      redirect '/sign_up'
    end
    unless Details.authenticate_password(params[:password])
      flash[:notice] = "Please enter a valid password"
      redirect '/sign_up'
    end
    session[:user] = User.create(name: params[:name], email: params[:email], password: params[:password])
    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/listings'
  end

  get '/log_in' do
    erb :"users/log_in"
  end

  post '/log_in' do
    unless session[:user] = User.authenticate(email: params[:email], password: params[:password])
      flash[:notice] = 'Your email and password do not match'
      redirect '/log_in'
    end

    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/listings'
  end

  post '/log_out' do
    session.clear 
    flash[:notice] = 'You have logged out.'
    redirect '/'
  end
  
  get '/bookings' do
    @user = User.find_by_user_id(session[:user_id]) if session[:user_id]
    @outgoing_bookings = Booking.outgoing_bookings(user_id: session[:user].user_id)
    @incoming_bookings = Booking.incoming_bookings(user_id: session[:user].user_id)
    erb :"/bookings/index"
  end

  get '/noodle' do
    "I ACCEPT"
  end

  post '/bookings/new/:listing_id' do
    Booking.create(start_date: params[:start_date], end_date: params[:end_date], listing_id: params[:listing_id], user_id: session[:user].user_id)
    redirect '/bookings' 
  end

  get '/bookings/:booking_id' do
    @booking = Booking.find_by_booking_id(booking_id: params[:booking_id])
    @listing = Listing.find_by_listing_id(listing_id: @booking.listing_id)
    @incoming_bookings = Booking.incoming_bookings(user_id: session[:user].user_id)
    @user = User.find_by_user_id(user_id: @booking.user_id)
    erb :"/bookings/index"
  end


  run! if app_file == $0
end
