require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base

  enable :sessions
  
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/user' do
    session[:name] = params[:name]
    redirect '/'
  end

  run! if app_file == $0
end
