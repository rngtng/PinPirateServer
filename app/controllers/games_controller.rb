class GamesController < ApplicationController

  def index
    @game  = Game.latest.first
    @games = Game.limit(30).order("score DESC").all

    if request.xhr?
      render :json => @game.to_json( :only => [:id, :score, :slot, :name], :include => [:player], :methods => [:score_s] )
    end
  end
end
