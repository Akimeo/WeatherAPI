# frozen_string_literal: true

describe API::V1::Health, type: :request do
  include Rack::Test::Methods

  def app
    API::V1::Health
  end

  describe 'GET /api/v1/health' do
    it 'returns ok status' do
      get '/api/v1/health'

      expect(last_response.status).to eq(200)
    end
  end
end
