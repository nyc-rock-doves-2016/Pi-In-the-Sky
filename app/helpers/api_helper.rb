module ApiHelper

  def call_breezy_api(object)
    url = HTTParty.get("https://api.breezometer.com/baqi/?location=#{object.city},+#{object.state}&key=c0bfb33a27924f7e95a828abc931d5a0", :verify => false)
    response = JSON.parse(url.body)
  end

end
