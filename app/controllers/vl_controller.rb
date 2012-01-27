class VlController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def bc
    send_file File.join('public', 'bootcode.bin')
  end

  def button
    respond_to do |format|
      format.jsp { send_nabaztag(1) }
    end
  end

  def log
    @log = params[:logs].to_s.split("|")
    puts "#########################"
    @log.each do |line|
      type, time, *values = line.split(",")
      time = time.to_i
      values = values.map &:to_i

      if type == "moved"
        values << (time - values[1]) << (values[1] - values[2]) << (time - values[2]) << (time - values[3])
      end
      puts "#{type}-#{time}: #{values.join("\t")}"
    end
    puts "#########################"
    respond_to do |format|
      format.jsp { send_nabaztag OK }
    end
  end

  private
  def msg
    {
      LOG => [],
      LED_0 => 0,
      LED_1 => 0,
      LED_2 => 0,
      LED_3 => 0,
      LED_4 => 0,
      #EAR_L => 0, #[F,B,F,B,F,B,F,B,F,B,F,B],
      EAR_R => 0, #[F,B,F,B,F,B,F,B,F,B,F,B], #0, #[0,0,0,0,0,0,0,0,0,0,0,0,F,B,F,B,F,B,F,B,F,B,F,B]

      LED_L0 => [0,0,0,0], #0xFF, #[0,0xFF,0,0xFF,0,0xFF,0,0xFF,0,0xFF]
      LED_L1 => 0,#[0xFF,0,0,0,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF],
      LED_L2 => 0,#[0xFF,0,0,0,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00],
      LED_L3 => 0,#[0xFF,0,0,0,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF,0x00,0x00],
      LED_L4 => 0,
      EAR_LL => 10,
      EAR_LR => 0,
    }
  end
end

