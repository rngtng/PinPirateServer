class VlController < ApplicationController

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

  def debug
    respond_to do |format|
      format.jsp { send_data Nabaztag::ok, :status => 200 }
    end
  end
end
