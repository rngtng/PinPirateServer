class GamesController < ApplicationController

  def index
    @game  = Game.latest.first
    @games = Game.limit(10).all
  end

  def create
  end
end
