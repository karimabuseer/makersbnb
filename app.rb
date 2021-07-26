require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/sign_up' do
    erb :"users/sign_up"
  end

  post '/user' do
    session[:name] = params[:name]
    redirect '/'
  end

  get '/log_in' do
    erb :"users/log_in"
  end

  post '/log_in' do
    session[:name] = params[:email]
    redirect '/'
  end

  post '/log_out' do
    session.clear
    flash[:notice] = 'You have logged out.'
    redirect '/'
  end
  
  run! if app_file == $0
end
