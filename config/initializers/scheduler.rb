# frozen_string_literal: true

require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.in '3s' do
  PullWeatherJob.perform_now(initial: true)
end

s.every '1h' do
  PullWeatherJob.perform_now
end
