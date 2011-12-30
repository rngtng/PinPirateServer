class GamesController < ApplicationController

  def index
    @game  = Game.latest.first
    @games = Game.limit(30).order("high_score DESC").all

    if request.xhr?
      render :json => @game.to_json( :only => [:id, :high_score, :slot, :name], :include => [:player], :methods => [:high_score_s] )
    end
  end
end
