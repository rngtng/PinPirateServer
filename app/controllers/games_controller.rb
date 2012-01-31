require 'nabaztag_hack_kit/message/helper'

class GamesController < ApplicationController
  include NabaztagHackKit::Message::Helper

  def index
    @games = case params[:filter]
      when 'daily'
        Game.finished.where(["created_at > ?",]).order("score DESC").limit(30).all
      when 'alltime'
        Game.finished.order("score DESC").limit(30).all
      when 'player'
        Game.finished.order("score DESC").limit(30).all
      else
        Game.not_finished.order("updated_at DESC")
    end

    if request.xhr?
      render :json => @games.to_json( :only => [:id, :score, :slot, :name, :twitter_handle], :include => [:player], :methods => [:score_s] )
    end
  end

  def show
    @games = Game.finished.not_tweeted.each do |game|
      game.tweet!
    end
    render :json => @games.to_json(:only => [:id, :player_id])
  end

  def button
    respond_to do |format|
      format.jsp do
        send_nabaztag fire
      end
    end
  end

end
