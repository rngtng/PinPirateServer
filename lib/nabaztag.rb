module Nabaztag
  module  Message
    module Commands
      OK     = 3
      ERROR  = 8
      REBOOT = 9
      LED_L0 = 20
      LED_L1 = 21
      LED_L2 = 22
      LED_L3 = 23
      LED_L4 = 24
      EAR_LL = 25
      EAR_LR = 26

      LED_0 = 30
      LED_1 = 31
      LED_2 = 32
      LED_3 = 33
      LED_4 = 34
      EAR_L = 35
      EAR_R = 36

      F = 1
      B = 2
    end

    module Helpers
      #blink
      def bl(loops = 1, color_on = 0xFF, color_off = 0x00)
        repeat(loops, [color_on, color_off])
      end

      #repeat
      def rp(loops, pattern = 0)
        Array.new(loops, pattern).flatten
      end
      alias_method :sl, :rp #sleep

      #knight rider
      def kr(color = 0xFF, led1 = LED_L1, led2 = LED_L2, led3 = LED_L3)
        {
          led1 => [color,0,0,0],
          led2 => [0,color],
          led3 => [0,0,color,0]
        }
      end
    end

    def build(*commands)
      commands = if commands.first.is_a?(Hash)
        commands.first
      elsif !commands.first.is_a?(Array)
        [commands]
      else
        commands
      end

      full_message commands.map { |cmd, *data|
        [cmd] + to_3b(data.flatten.size) + data.flatten
      }
    end
    module_function(:build)

    def to_3b(int)
      [int >> 16, (int >> 8) & 0xFF, int & 0xFF]
    end
    module_function(:to_3b)

    private
    def full_message(*data)
      [0x7F] + data.flatten + [0xFF, 0x0A]
    end
    module_function(:full_message)
  end

end
