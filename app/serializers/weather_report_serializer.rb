# frozen_string_literal: true

class WeatherReportSerializer < ActiveModel::Serializer
  attributes :time, :temperature
end
