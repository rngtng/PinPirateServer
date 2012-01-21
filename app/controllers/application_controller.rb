class ApplicationController < ActionController::Base
  include Nabaztag::Message::Commands

  protect_from_forgery

  def send_nabaztag(*data)
    send_data Nabaztag::Message.build(*data).pack('c*'), :status => 200
  end
end
