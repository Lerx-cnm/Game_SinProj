class SessionController < ApplicationController
      get '/login' do
        erb :'/session/login'
      end
      
      post '/login' do
        @user = User.find_by(email: params[:email], password_digest: params[:password])
        if !@user 
            # @error = "Please make sure all fields are filled in and correct."
            # binding.pry
            redirect '/login'
        elsif @user
          session[:user_id] = @user.id
          redirect '/users/home'
        end
    #     @error = "Please make sure all fields are filled in and correct."
    #   redirect '/login'
      end

      get '/logout' do
        logout
        redirect '/'
      end

end