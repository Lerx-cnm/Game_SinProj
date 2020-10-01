class GameController < ApplicationController
     #This is my 'new' RESTful route
    get '/games/new' do
        if logged_in?
        erb :'/games/new'
        else 
            redirect '/login'
        end
      end
    
    post '/games/new' do
        if params[:name] != "" && params[:genre] != "" && params[:price] != ""
        @game = Game.new(name: params[:name], genre: params[:genre],price:  params[:price], user_id: current_user.id)
        @game.save
        redirect '/games/new'
        else
            @error = "*Please make sure all fields are filled in*"
            erb :'/games/new'
        end
    end
    #/games is my 'index' RESTful route
    get '/games' do
        if logged_in? && current_user.id == session[:user_id]
          @games = Game.where(user_id: @current_user.id)
        erb :'/users/games'
        else
            redirect '/login'
        end
    end
    #/games/:id/edit is my 'update' RESTful route
    get '/games/:id/edit' do
        @games = Game.find_by(id: params[:id])
        if logged_in? && @games.user_id == session[:user_id]
        erb :'/games/edit'
        else 
            redirect '/login'
        end
    end
    patch '/games/:id/edit' do
        # Only need to check logged_in in the 'get'
        @games = Game.find_by(id: params[:id])
        if logged_in? && @games.user_id == session[:user_id]
          @games.update(name: params[:name], genre: params[:genre], price: params[:price])
          @games.save
          redirect '/games'
        else 
          redirect '/login'
        end
    end
    #/games/:id/delete this is my 'delete' RESTful route
    delete '/games/:id/delete' do
        @game = Game.find_by(id: params[:id])
        if logged_in? && @game.user_id == session[:user_id]
        @game.destroy
        redirect '/games'
        else
            redirect '/login'
        end
    end
end