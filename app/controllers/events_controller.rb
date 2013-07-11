class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    size, *data = params[:event][:data]

    size = size.to_i(16)
    if size != data.size
      raise "Wrong size: #{size} - #{data.inspect}"
    end

    @event = if (size == 5) && (1..4).member?(Game.get_slot(data.first)) #todo: Game.is_slot?()
      ScoreEvent.create!(:data => data.join)
    else
      Event.create!(:data => data.join)
    end

    render :json => @event.to_json(:only => [:id, :game_id], :methods => [:score])
  end
end
