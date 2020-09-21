require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, ENV.fetch('SESSION_SECRET'){SecureRandom.hex(64)}
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
    @user = User.new(name: params[:name], email: params[:email], password_digest: params[:password])
    # binding.pry
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password_digest: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
  redirect '/sessions/login'
  end

  get '/sessions/login' do
    @user = User.find_by(email: params[:email], password_digest: params[:password])
    if @user 
      redirect '/users/home'
    else
      redirect '/'
    end
  end

  get '/users/logout' do
    session.clear
    redirect '/'
  end
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
      
  get '/users/new' do
    Game.all
  end
  
  get '/games/new' do
    erb :'/games/new'
  end

  post '/games/new' do
    @user = User.find(session[:user_id])
    # binding.pry
    @game = Game.new(name: params[:name], genre: params[:genre], price: params[:price], user_id: @user.id)
    @game.save
    binding.pry
    redirect '/games/new'
  end
  helpers do
    def logged_in?
      !!current_user
    end
    def current_user
      @current_user ||= User.find_by(id:session[:user_id]) if session[:user_id]
    end
    def logout 
      session.clear
    end
  end
end
