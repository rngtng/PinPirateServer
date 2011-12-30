class GamesController < ApplicationController

  def index
    @games = Game.first
    @games = Game.limit(10).all
  end

end
