require "net/http"

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

class ApiClient
  API_EVENT_URI = "/events"

  def initialize(uri)
    @url = URI.parse(uri)
    @http = Net::HTTP.new(@url.host, @url.port)
  end

  def write(data)
    data = data.strip.split(",").to_hex
    resp, data = @http.post( API_EVENT_URI, {:event => { :data => data } }.to_query )
  end

end