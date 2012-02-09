require 'nabaztag_hack_kit/message/helper'

class GamesController < ApplicationController
  include NabaztagHackKit::Message::Helper

  def index
    basic_sql = Game.finished.limit(30).order("score DESC")
    @games = case params[:filter]
      when 'daily'
        basic_sql.where(["finished_at > ?", Date.today])
      when 'alltime'
        basic_sql
      when 'player'
        join_sql = basic_sql.group("player_id").select("player_id, MAX(score) score").to_sql
        basic_sql.from("`games`, (#{join_sql}) g2").where("`games`.player_id = g2.player_id AND `games`.score = g2.score")
      else
        Game.not_finished.order("updated_at DESC")
    end

    if request.xhr?
      render :json => @games.to_json( :only => [:id, :score, :slot, :name, :twitter_handle, :updated_at], :include => [:player], :methods => [:score_s, :duration] )
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

        send_nabaztag(
          LED_0 => 0,
          LED_1 => 0,
          LED_2 => 0,
          LED_3 => 0,
          LED_4 => 0,
          LED_L0 => 0,
          LED_L1 => 0,
          LED_L2 => 0,
          LED_L3 => 0,
          LED_L4 => 0,
          EAR_L  => 0,
          EAR_R  => 0,
          EAR_LL => 0,
          EAR_LR => 0,
        )
      end
    end
  end

end
