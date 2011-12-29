class EventsController < ApplicationController

  # def index
  # end
  #
  # def show
  # end

  def create
    @game = Game.find(params[:game_id])
    event = @game.events.new(params[:event])
    event.type = params[:type] if params[:type]
    event.save

    render :json => @game #TODO return event here??
  rescue => e
    render :json => {}, :status => 404
  end
end
