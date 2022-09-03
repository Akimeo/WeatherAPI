# frozen_string_literal: true

class PullWeatherService
  def initialize
    @client = AccuWeatherClient.new
  end

  def call(initial)
    data = JSON.parse(@client.pull_data(initial).body)
    data.each do |d|
      WeatherReport.create!(
        time: Time.at(d['EpochTime']).beginning_of_hour,
        temperature: d['Temperature']['Metric']['Value']
      )
    end
  end
end
