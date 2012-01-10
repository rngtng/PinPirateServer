class PlayersController < ApplicationController

  respond_to :json
  def create
  end

  def update
    @player     = Player.find(params[:id])
    @new_player = Player.find_or_build_by(:name => params[:player][:name])

    @player.games.latest.first.update_attributes(:player => @new_player)

    respond_with @new_player
  end
end
