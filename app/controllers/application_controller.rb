require 'nabaztag_hack_kit/message'
require 'nabaztag_hack_kit/message/api'

class ApplicationController < ActionController::Base
  include NabaztagHackKit::Message::Api
  # include NabaztagHackKit::Message::Helper

  protect_from_forgery

  def send_nabaztag(*data)
    send_data NabaztagHackKit::Message.build(*data), :status => 200
  end
end
