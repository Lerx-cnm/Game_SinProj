class GameController < ApplicationController 
    get '/games/new' do
        if logged_in?
        erb :'/games/new'
        else 
            redirect '/login'
        end
      end
    
    post '/games/new' do
        # binding.pry
        if params[:name] != "" && params[:genre] != "" && params[:price] != ""
            binding.pry
        @game = Game.new(name: params[:name], genre: params[:genre],price:  params[:price], user_id: current_user.id)
        @game.save
        # binding.pry
        redirect '/games/new'
        else
            @error = "*Please make sure all fields are filled in*"
            erb :'/games/new'
        end
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
        @games = Game.find_by(id: params[:id])
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
        # binding.pry
        if logged_in? && @games.user_id == session[:user_id]
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