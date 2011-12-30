class GamesController < ApplicationController

  def index
    @game  = Game.latest.first
    @games = Game.limit(10).all

    if request.xhr?
      render :json => @game.to_json( :only => [:id, :high_score, :slot, :name], :include => [:player], :methods => [:high_score_s] )
    end
  end
end
