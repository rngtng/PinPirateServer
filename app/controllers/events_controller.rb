class EventsController < ApplicationController

  # def index
  # end
  #
  # def show
  # end

  def create
    @game = Game.recent.first || Game.create!(:name => 'Player 1')
    @event = @game.score_events.new(params[:event])
  #  @event.type = params[:type] if params[:type]  #TODO later just event
    @event.save!

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  rescue => e
    render :json => {}, :status => 404
  end
end
