class PlayersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:update]

  respond_to :html, :json

  def update
    respond_to do |format|
      format.jsp do
        @message = if @new_player = Player.find_by_rfid_id(params[:id])
          @game  = Game.latest.first.update_attributes(:player => @new_player)
          { LED_0 => 0xFF00FF }
        else
          ERROR
        end
        send_nabaztag @message
      end

      format.any(:html, :json) do
        if @player = Player.find_by_id(params[:id])
          @new_player = Player.find_or_build_by(:name => params[:player][:name])
          @player.games.latest.first.update_attributes(:player => @new_player)
        end

        respond_with @new_player
      end
    end
  end
end
