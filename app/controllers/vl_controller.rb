class VlController < ApplicationController

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

  def debug
    respond_to do |format|
      format.jsp { send_data msg2, :status => 200 }
    end
  end

  private
  def msg
    Nabaztag::send(:full_message,
     m(20,0,255),
     m(21,0,255),
     m(22,0,255),
     m(23,0,255),
     m(24,0,255),
    )
  end

  def msg2
    Nabaztag::send(:full_message,
     m(24,0),
     m(21,255,255,0,0,0,0,0,0),
     m(22,0,0,255,255),
     m(23,0,0,0,0,255,255,0,0),
     m(20,0,10,20,30,40,50,60,70,80,90),
    )
  end

  def m(cmd, *data)
    data = data.flatten.compact
    [cmd] + [0x00, 0x00, data.size] + data
  end

end

