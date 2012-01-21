class VlController < ApplicationController

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

  def debug
    respond_to do |format|
      format.jsp { send_data msg3, :status => 200 }
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
      m(20,0,10,20,30,40,50,60,70,80,90),
      m(21,255,255,0,0,0,0,0,0),
      m(22,0,0,255,255),
      m(23,0,0,0,0,255,255,0,0),
      m(24,0),
    )
  end

  def msg3
    Nabaztag::send(:full_message,
      m(20,0),
      #m(21,0),
      m(22,0),
      m(23,0),
      m(24,0),

      m(25,1),
      m(26,2),

      m(30,255),
      m(31,1),

      m(35,0,2,0,2,0,2,0,2,0,2),
      m(36,1,1,1,1,1,1,1,1,1,1,1,0,2,0,2,0,2,0,2,0),
      #m(24,0,0,0,0,0,0,0,0,1,1,1,1,1,1),
      #m(25,0,255,0,255,0,255,0,255,0,255),
      #m(21,0xFF,0,0,0,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF),
      #m(22,0xFF,0,0,0,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00),
      #m(23,0xFF,0,0,0,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00)
    )
  end

  def m(cmd, *data)
    data = data.flatten.compact
    [cmd] + [0x00, 0x00, data.size] + data
  end

end

