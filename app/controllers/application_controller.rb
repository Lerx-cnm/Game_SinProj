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
    erb :'/session/login'
  end

  get '/signup' do
    erb :'/session/signup'
  end

  post '/registration' do
    if User.find_by(email: params[:email])
      redirect '/'
    else
    @user = User.new(name: params[:name], email: params[:email], password_digest: params[:password])
    # binding.pry
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
    end
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
    logout
    redirect '/'
  end
  get '/users/home' do
    redirect '/' if !logged_in?
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
    # binding.pry
    redirect '/games/new'
  end
  get '/games/:id/edit' do
    @game = Game.find(params[:id])
    erb :'/games/edit'
  end

  # patch '/games/:id' do
  #   game = Game.find(param[:id])
  #   game.update(params[:game])
  #   redirect '/game/#{params[:id]}'
  # end

  helpers do
    def logged_in?
      session[:user_id]
    end
    def current_user
      @current_user = User.find(session[:user_id])
    end
    def logout 
      session.clear
    end
  end
  get '/users/games' do
    current_user 
    # binding.pry
    @games = Game.where(user_id: @current_user.id)
    # binding.pry

    erb :'/users/games'
  end
  get '/games/update/:id' do
    @game = Game.find(params[:id])
    erb :'/games/edit'
  end
  post '/games/update/:id' do
    @id = Game.find_by(id: params[:id])
    @id.update(name: params[:name], genre: params[:genre], price: params[:price])

    binding.pry
    @id.save
    redirect '/users/games'
  end
  get '/games/delete/:id' do
    current_user
    @delete = Game.find_by(id: params[:id])
    @delete.destroy
    redirect '/users/games'
  end
end
