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

  get '/listings/:listing_id' do
    @listing = Listing.find_by_listing_id(listing_id: params[:listing_id])
    erb(:'/listings/book')
  end

  post '/bookings/new/:listing_id' do
    # Bookings.create(start: params[:start], end:params[:end], id: params[:id])
    p params[:start_date], params[:end_date], params[:listing_id]
  end

  get '/sign_up' do
    erb :"users/sign_up"
  end

  post '/user' do
    session[:user] = User.create(name: params[:name], email: params[:email], password: params[:password])
    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/listings'
  end

  get '/log_in' do
    erb :"users/log_in"
  end

  post '/log_in' do
    session[:user] = User.find(params[:email])
    flash[:notice] = "Welcome #{session[:user].name}!"
    redirect '/listings'
  end

  post '/log_out' do
    session.clear 
    flash[:notice] = 'You have logged out.'
    redirect '/'
  end
  
  get '/bookings' do
      @bookings = Booking.all
    erb :"/bookings/index"
  end

  run! if app_file == $0
end
