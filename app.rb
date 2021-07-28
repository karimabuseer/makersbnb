require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'pg'
require 'bcrypt'
require './lib/user'
require_relative './lib/listing'
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
  
  run! if app_file == $0
end
