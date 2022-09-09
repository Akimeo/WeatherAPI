# frozen_string_literal: true

class AccuWeatherClient
  ROOT_ENDPOINT = 'http://dataservice.accuweather.com'
  CC_ENDPOINT = 'currentconditions/v1/'
  MOSCOW_LOCATION_KEY = '294021'
  HISTORICAL_STRING = '/historical/24'

  def initialize
    @http_client = setup_http_client
  end

  def pull_data(initial: false)
    request_string = CC_ENDPOINT + MOSCOW_LOCATION_KEY
    request_string += HISTORICAL_STRING if initial
    response = @http_client.get(request_string) do |request|
      request.params['apikey'] = ENV['AW_API_KEY']
    end
    JSON.parse(response.body)
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end
