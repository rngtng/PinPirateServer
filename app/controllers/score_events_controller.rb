class ScoreEventsController < ApplicationController

  before_filter :load_game

  def create
    @event = @game.score_events.create!(params[:event])

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  rescue => e
    render :json => {}, :status => 404
  end

  private
  def load_game
    @game = Game.latest(params[:game_id]).first
  end
end
