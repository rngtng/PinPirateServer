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
      LED_0 => 0,
      LED_1 => 0,
      LED_2 => 0,
      LED_3 => [10, 0x10],
      LED_4 => 0,
      EAR_L => 0, #[F,B,F,B,F,B,F,B,F,B,F,B],
      EAR_R => 0, #[F,B,F,B,F,B,F,B,F,B,F,B], #0, #[0,0,0,0,0,0,0,0,0,0,0,0,F,B,F,B,F,B,F,B,F,B,F,B]

      LED_L0 => [0xFF0000], #0xFF, #[0,0xFF,0,0xFF,0,0xFF,0,0xFF,0,0xFF]
      LED_L1 => [0xFF,0,0,0,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF],
      LED_L2 => [0xFF,0,0,0,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00],
      LED_L3 => [0xFF,0,0,0,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00],
      LED_L4 => 0,
      EAR_LL => 0,
      EAR_LR => 0,
    }
  end
end

