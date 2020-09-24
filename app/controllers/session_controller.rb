class SessionController < ApplicationController
      get '/login' do
        erb :'/session/login'
      end
      
      post '/login' do
        @user = User.find_by(email: params[:email])
        # binding.pry
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          # binding.pry
            redirect '/users/home'
        else 
          @error = "*Please make sure credentials are filled in and valid*"
          erb :'/session/login'
        end
      end

      get '/logout' do
        logout
        redirect '/'
      end

end