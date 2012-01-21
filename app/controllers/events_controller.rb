class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    size, *data = params[:event][:data].to_s.scan(/../)

    if size.to_i(16) != data.size
      raise "Wrong size: #{size.to_i(16)} - #{data.inspect}"
    end

    @event =  if (size.to_i(16) == 5) && (1..4).member?(Game.get_slot(data.first))
      @message = { LED_0 => 0xFFFF00 }
      ScoreEvent.create!(:data => data.join)
    else
      @color = { LED_0 => 0x0000FF }
      Event.create!(:data => data.join)
    end

    respond_to do |format|
      format.jsp  { send_nabaztag @message }
      format.any(:html, :json) { render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score]) }
    end

  rescue => e
    respond_to do |format|
      format.jsp  { send_nabaztag ERROR }
      format.any(:html, :json) { render :json => {}, :status => 400 }
    end
  end
end
