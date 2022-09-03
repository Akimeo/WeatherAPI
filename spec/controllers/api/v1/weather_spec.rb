# frozen_string_literal: true

describe API::V1::Weather, type: :request do
  include Rack::Test::Methods

  def app
    API::V1::Weather
  end

  let!(:weather_reports) do
    build_list(:weather_report, 25) do |record, i|
      # Список отчетов о погоде с интервалом в 1 час (24.05.2021 00:00 - 25.05.2021 00:00).
      # Температура каждый час возрастает на 1 градус.
      # Крайнее значение (24.05.2021 00:00, температура 24) не попадает в historical.
      record.time = Time.local(2021, 'may', 25) - i.hours
      record.temperature = i
      record.save!
    end
  end

  describe 'GET /api/v1/weather/by_time' do
    it 'returns closest to the sent timestamp temperature' do
      get '/api/v1/weather/by_time?timestamp=1621823790'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['temperature']).to eq 19
    end

    it 'returns 404 error when there is no matching time' do
      get '/api/v1/weather/by_time?timestamp=1662214930'

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)['error']).to eq 'not_found'
    end
  end

  describe 'GET /api/v1/weather/current' do
    it 'returns current temperature' do
      get '/api/v1/weather/current'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['temperature']).to eq 0
    end
  end

  describe 'GET /api/v1/weather/historical' do
    it 'returns hourly temperature over 24 hours' do
      get '/api/v1/weather/historical'

      historical = JSON.parse(last_response.body)

      expect(last_response.status).to eq(200)
      expect(historical.length).to eq 24
      expect(historical.first['time'].to_time).to eq Time.local(2021, 'may', 25)
      expect(historical.last['time'].to_time).to eq Time.local(2021, 'may', 24, 1)
    end
  end

  describe 'GET /api/v1/weather/historical/max' do
    it 'returns maximum temperature over 24 hours' do
      get '/api/v1/weather/historical/max'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['temperature']).to eq 23
    end
  end

  describe 'GET /api/v1/weather/historical/min' do
    it 'returns minimum temperature over 24 hours' do
      get '/api/v1/weather/historical/min'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['temperature']).to eq 0
    end
  end

  describe 'GET /api/v1/weather/historical/avg' do
    it 'returns average temperature over 24 hours' do
      get '/api/v1/weather/historical/avg'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['temperature']).to eq 11.5
    end
  end
end
