require "net/http"

class Tweet
  API_URL = "http://machinetweets.com/t/nabaccia/ieustnxbf7uhf6ai"

  def self.do(text)
    resp, data = http.post(url.path, { :status => text }.to_query )
  end

  def self.http
    @@http ||= Net::HTTP.new(url.host, url.port)
  end

  def self.url
    @@url ||= URI.parse(API_URL)
  end
end