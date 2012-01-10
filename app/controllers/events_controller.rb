class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    size, *data = params[:event][:data].to_s.scan(/../)

    if size.to_i(16) != data.size
      raise "Wrong size: #{size.to_i(16)} - #{data.inspect}"
    end

    @event =  if (size.to_i(16) == 5) && (1..4).member?(Game.get_slot(data.first))
      ScoreEvent.create!(:data => data.join)
    else
      Event.create!(:data => data.join)
    end

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  rescue => e
    render :json => {}, :status => 400
  end
end
