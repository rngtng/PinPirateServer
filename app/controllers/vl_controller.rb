class VlController < ApplicationController

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

  def debug
    respond_to do |format|
      format.jsp { send_nabaztag msg }
    end
  end

  private
  def msg
    {
      LED_L0 => 0, #[0,0xFF,0,0xFF,0,0xFF,0,0xFF,0,0xFF]
      LED_L1 => 0, #[0xFF,0,0,0,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF],
      LED_L2 => 0, #[0xFF,0,0,0,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00],
      LED_L3 => 0, #[0xFF,0,0,0,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00],
      LED_L4 => 0,
      EAR_LL => F,
      EAR_LR => B,

      LED_0 => 0xFF,
      LED_1 => 0,
      LED_2 => 0,
      LED_3 => 0,
      LED_4 => 0,
      EAR_L => 0, #[F,B,F,B,F,B,F,B,F,B,F,B]
      EAR_R => 0, #[0,0,0,0,0,0,0,0,0,0,0,0,F,B,F,B,F,B,F,B,F,B,F,B]
    }
  end
end

