# frozen_string_literal: true

require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

# Ужасный костыль
initial = true

s.every '1h' do
  PullWeatherJob.perform_now(initial)
  initial = false
end
