class VlController < ApplicationController

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

end
