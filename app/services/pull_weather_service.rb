# frozen_string_literal: true

class PullWeatherService
  def initialize
    @client = AccuWeatherClient.new
  end

  def call(initial: false)
    data = @client.pull_data(initial:)
    data.each do |d|
      WeatherReport.create!(
        time: Time.at(d['EpochTime']).beginning_of_hour,
        temperature: d['Temperature']['Metric']['Value']
      )
    end
  end
end
