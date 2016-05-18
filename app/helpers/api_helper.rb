module ApiHelper

  def call_breezy_api(object)
    url = "https://api.breezometer.com/baqi/?location=#{object.city},+#{object.state}&key=c0bfb33a27924f7e95a828abc931d5a0"
    # binding.pry
    if url.ascii_only?
      party_url = HTTParty.get(url, :verify => false)
      response = JSON.parse(party_url.body)
    end
  end

end
