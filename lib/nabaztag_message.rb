class NabaztagMessage
  class << self
    def ok
      message 3
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