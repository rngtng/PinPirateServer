class GamesController < ApplicationController

  def index
    @game  = Game.first
    @games = Game.limit(10).all
  end

end
