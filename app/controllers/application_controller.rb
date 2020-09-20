require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "8ret4e"
  end

  get "/" do
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end
  post '/registration' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.user_id
      redirect 'users/home'
    end
  redirect '/sessions/login'
  end
  get 'users/home' do
    erb :'users/home'
  end
end
