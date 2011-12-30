class GamesController < ApplicationController

  def index
    @game  = Game.current.first || Game.new(:player => Player.last)
    @games = Game.finished.order("score DESC").limit(30).all

    if request.xhr?
      render :json => @game.to_json( :only => [:id, :score, :slot, :name, :twitter_handle], :include => [:player], :methods => [:score_s] )
    end
  end

  def show
    @games = Game.finished.not_tweeted.each do |game|
      game.tweet!
    end
    render :json => @games.to_json(:only => [:id, :player_id])
  end
end
