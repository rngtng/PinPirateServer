class Hash
  def to_query(namespace = nil)
    collect do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end
end

class String
  def to_query(key)
    "#{key}=#{self}"
  end
end


class Array
  def to_hex
    self.map { |d| "%02x" % d.to_i(16) }.join
  end
end

class PinPirateClient
  API_SCORE_URI = "/games/1/scores"
  API_URL = {
    :production  => "http://p.warteschlange.de:8080",
    :development => "http://localhost:3000",
  }

  def initialize(env = nil)
    @url = URI.parse(API_URL[env || :production])
    @http = Net::HTTP.new(@url.host, @url.port)
  end

  def process(size, *data)
    return unless data.any?

    if size.to_i(16) != data.size
      raise "Wrong size: #{size.to_i(16)} - #{data.inspect}"
    end

    case data.first
      when "C", "D", "E", "F"
        self.score(data)
      else
        self.event(data)
    end
    data
  end

  def score(data)
    resp, data = @http.post( API_SCORE_URI, {:event => { :data => data.to_hex } }.to_query )
  end

  def event(data)
    # resp, data = @http.post( API_EVENT_URI, {:event => { :data => data.to_hex } }.to_query )
  end
end