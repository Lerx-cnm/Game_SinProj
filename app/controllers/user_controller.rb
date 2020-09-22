class UserController < ApplicationController
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
      
      get '/users/home' do
        redirect '/' if !logged_in?
        @user = User.find(session[:user_id])
        erb :'/users/home'
      end
end