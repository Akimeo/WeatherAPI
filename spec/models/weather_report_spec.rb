# frozen_string_literal: true

describe WeatherReport, type: :model do
  it { should validate_presence_of :temperature }
  it { should validate_presence_of :time }
end
