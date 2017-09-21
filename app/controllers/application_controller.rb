require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id].nil?
      erb :signup
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      redirect to "/tweets"
    end
  end

  get '/login' do
    if session[:user_id].nil?
      erb :login
    else
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect to "/tweets"
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

end
