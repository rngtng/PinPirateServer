class ScoreEventsController < ApplicationController

  def create
    @event = ScoreEvent.create!(params[:event])

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  rescue => e
    render :json => {}, :status => 404
  end
end
