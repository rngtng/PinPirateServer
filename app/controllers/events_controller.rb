class EventsController < ApplicationController

  # def index
  # end
  #
  # def show
  # end

  def create
    @game = Game.find(params[:game_id])
    @event = @game.score_events.new(params[:event])
  #  @event.type = params[:type] if params[:type]
    @event.save!

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  rescue => e
    render :json => {}, :status => 404
  end
end
