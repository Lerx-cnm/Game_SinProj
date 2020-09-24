class GameController < ApplicationController 
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

    get '/games' do
        # binding.pry
        if logged_in? && current_user.id == session[:user_id]
          @games = Game.where(user_id: @current_user.id)
        # binding.pry 
        erb :'/users/games'
        else
            redirect '/login'
        end
    end

    get '/games/:id/edit' do
        # binding.pry
        @games = Game.find_by(params[:id])
        # binding.pry
        if logged_in? && @games.user_id == session[:user_id]
        # binding.pry
        erb :'/games/edit'
        else 
            redirect '/login'
        end
    end

    patch '/games/:id/edit' do
        @games = Game.find_by(id: params[:id])
        binding.pry
        if logged_in? && @game.user_id == session[:user_id]
          @games.update(name: params[:name], genre: params[:genre], price: params[:price])
          @games.save
          redirect '/games'
        else 
          redirect '/login'
        end
    end

    delete '/games/:id/delete' do
        @game = Game.find_by(id: params[:id])
        # binding.pry
        if logged_in? && @game.user_id == session[:user_id]
        @game.destroy
        redirect '/games'
        else
            redirect '/login'
        end
    end
end