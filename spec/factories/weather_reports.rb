# frozen_string_literal: true

FactoryBot.define do
  factory :weather_report do
    time { Time.current }
    temperature { 0 }
  end
end
