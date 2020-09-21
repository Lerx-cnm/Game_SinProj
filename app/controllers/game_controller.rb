class GameController < ApplicationController 

  get '/games/new' do
    erb :'/games/new'
  end

  post '/games/new' do
    Game.new(name: params[:name], genre: params[:genre], price: params[:price], user_id: @user.id)
    redirect '/games/new'
  end
end