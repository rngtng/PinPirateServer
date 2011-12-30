class EventsController < ApplicationController

  before_filter :load_game

  def create
    @event = @game.events.create!(params[:event])

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  end

  private
  def load_game
    @game = Game.find params[:game_id]
  rescue => e
    render :json => {}, :status => 404
  end
end
