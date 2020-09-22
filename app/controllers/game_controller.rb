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
    
        # binding.pry
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