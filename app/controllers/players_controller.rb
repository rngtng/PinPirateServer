class PlayersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:show]

  respond_to :json

  def show
    respond_to do |format|
      format.jsp { send_data NabaztagMessage::message(2, 255, 0, 255), :status => 200 }
    end
  end

  def create
  end

  def update
    @player     = Player.find(params[:id])
    @new_player = Player.find_or_build_by(:name => params[:player][:name])

    @player.games.latest.first.update_attributes(:player => @new_player)

    respond_with @new_player
  end
end
