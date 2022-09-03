# frozen_string_literal: true

class WeatherReport < ApplicationRecord
  validates :time, :temperature, presence: true

  HISTORICAL_LENGTH = 24

  scope :historical, -> { order(:time).last(HISTORICAL_LENGTH).reverse }

  def self.current
    order(:time).last.temperature
  end

  def self.historical_max
    historical.pluck(:temperature).max
  end

  def self.historical_min
    historical.pluck(:temperature).min
  end

  def self.historical_avg
    historical.pluck(:temperature).sum / HISTORICAL_LENGTH
  end

  def self.by_time(time)
    find_by(time: Time.at(time).beginning_of_hour)&.temperature
  end
end
