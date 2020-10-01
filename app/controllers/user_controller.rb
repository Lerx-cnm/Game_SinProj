class UserController < ApplicationController
    get '/signup' do
        erb :'/session/signup'
      end
      
      post '/signup' do
        if User.find_by(email: params[:email])
          redirect '/login'
        elsif params[:name] != "" && params[:email] != "" && params[:password] != ""
        @user = User.new(name: params[:name], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect '/users/home'
        else
          @error = "*Please make sure all fields are filled in and valid*"
          erb :'/session/signup'
        end
      end
      
      get '/users/home' do
        redirect '/' if !logged_in?
        @user = User.find_by(id: session[:user_id])
        erb :'/users/home'
      end
end