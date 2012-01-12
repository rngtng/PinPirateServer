class PlayersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:update]

  respond_to :json

  def update
    respond_to do |format|
      format.jsp do
        @message = if params[:id] == "d0021a0353030830"
          Nabaztag::reboot
        else
          if @new_player = Player.find_by_rfid_id(params[:id])
            @game  = Game.latest.first.update_attributes(:player => @new_player)
            Nabaztag::led(255, 0, 255)
          else
            Nabaztag::error
          end
        end

        send_data @message, :status => 200
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
