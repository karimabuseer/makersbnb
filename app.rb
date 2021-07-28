require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'pg'
require 'bcrypt'
require './lib/user'
require_relative './lib/listing'
require_relative './lib/bookings'
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
    erb(:'/listings/index')
  end

  get '/listings/add' do
    erb(:'/listings/add')
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price: params[:price])
    redirect '/listings'
  end

  get '/sign_up' do
    erb :"users/sign_up"
  end

  post '/user' do
    session[:user] = User.create(name: params[:name], email: params[:email], password: params[:password])
    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/'
  end

  get '/log_in' do
    erb :"users/log_in"
  end

  post '/log_in' do
    session[:user] = User.find(email: params[:email])
    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/'
  end

  post '/log_out' do
    session.clear 
    flash[:notice] = 'You have logged out.'
    redirect '/'
  end
  
  get '/bookings' do
    listing = Listing.create( 
      name: "sens hotel", 
      description: "castle", 
      price: "100")
    
    user = User.create(
      name: 'sen',
      email: 'banana@bread.com', 
      password: 'banana')
      
      Booking.create(
        start_date: '2021-10-10',
        end_date: '2021-11-12',
        user_id: user.user_id,
        listing_id: listing.listing_id)
    
        
      # Booking.create(start_date: '2021-10-10', end_date: '2021-11-12', listing_id: params[:listing_id], user_id: params[:user_id])
    erb :"/bookings/index"
  end

  run! if app_file == $0
end
