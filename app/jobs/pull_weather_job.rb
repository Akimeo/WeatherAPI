# frozen_string_literal: true

class PullWeatherJob < ApplicationJob
  queue_as :urgent

  def perform(initial)
    PullWeatherService.new.call(initial)
  end
end
