# frozen_string_literal: true

module API
  module V1
    class Weather < Grape::API
      include API::V1::Defaults

      namespace :weather do
        desc 'Return current temperature.'
        get :current do
          present :temperature, WeatherReport.current
        end

        desc 'Return closest to the sent timestamp temperature.'
        params do
          requires :timestamp, type: Integer, desc: 'Timestamp to search for.'
        end
        get :by_time do
          temperature = WeatherReport.by_time(params[:timestamp])
          error! :not_found, 404 unless temperature
          present :temperature, temperature
        end

        namespace :historical do
          desc 'Return hourly temperature over 24 hours.'
          get do
            present WeatherReport.historical
          end

          desc 'Return maximum temperature over 24 hours.'
          get :max do
            present :temperature, WeatherReport.historical_max
          end

          desc 'Return minimum temperature over 24 hours.'
          get :min do
            present :temperature, WeatherReport.historical_min
          end

          desc 'Return average temperature over 24 hours.'
          get :avg do
            present :temperature, WeatherReport.historical_avg
          end
        end
      end
    end
  end
end
