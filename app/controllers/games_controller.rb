require 'nabaztag_hack_kit/message/helper'

class GamesController < ApplicationController
  include NabaztagHackKit::Message::Helper

  def index
    @latest_games = Game.not_finished.order("slot ASC")[0..2] || [Game.new(:player => (Player.last || Player.new))]

    @games = Game.finished.order("score DESC").limit(30).all

    if request.xhr?
      render :json => @latest_games.to_json( :only => [:id, :score, :slot, :name, :twitter_handle], :include => [:player], :methods => [:score_s] )
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
