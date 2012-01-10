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
  API_EVENT_URI = "/events"
  API_URL = {
    :production  => "http://p.warteschlange.de:8080",
    :development => "http://localhost:3000",
  }

  def initialize(env = nil)
    @url = URI.parse(API_URL[env || :production])
    @http = Net::HTTP.new(@url.host, @url.port)
  end

  def process(*data)
    resp, data = @http.post( API_SCORE_URI, {:event => { :data => data.to_hex } }.to_query )
  end

end