class PlayersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:update]

  respond_to :html, :json

  def update
    respond_to do |format|
      format.jsp do
        @message = if @new_player = Player.find_by_rfid_id(params[:id])
          @game  = Game.not_finished.latest.first
          Game.update_all( {:player_id => @new_player.id}, {:id => @game.id})

          { LED_0+10 => rgb([0xFF0000, 0x00FF00, 0x0000FF]) }
        else
          ERROR
        end
        send_nabaztag @message
      end

      format.any(:html, :json) do
        if @player = Player.find_by_id(params[:id])
          @new_player = Player.find_or_create_by(:name => params[:player][:name])
          @game = @player.games.not_finished.latest.first
          Game.update_all( {:player_id => @new_player.id}, {:id => @game.id})
        end

        respond_with @new_player
      end
    end
  end
end
