class Nabaztag
  class << self
    def led(*data)
      message(2, *data)
    end

    def ok
      message 3
    end

    def error
      message 8
    end

    def reboot
      message 9
    end

    def message(cmd, *data)
      data = data.flatten.compact
      full_message [cmd] + [0x00, 0x00, data.size] + data
    end

    private

    def full_message(data)
      send_byte_array [0x7F] + Array(data) + [0xFF, 0x0A]
    end

    def send_byte_array(byte_array)
      byte_array.pack('c*')
    end
  end

end