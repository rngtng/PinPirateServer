class SerialClient
  def initialize(port, baud_rate)
    @serial_port = SerialPort.open(port, baud_rate)
  end

  def write(data)
    data.strip.split(",").each do |date|
      @serial_port.write date.to_i(16).chr
    end
    @serial_port.write 0xFF.chr
  end
end