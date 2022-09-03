# frozen_string_literal: true

describe WeatherReport, type: :model do
  it { should validate_presence_of :temperature }
  it { should validate_presence_of :time }

  let!(:weather_reports) do
    build_list(:weather_report, 25) do |record, i|
      # Список отчетов о погоде с интервалом в 1 час (24.05.2021 00:00 - 25.05.2021 00:00).
      # Температура каждый час возрастает на 1 градус.
      # Крайнее значение (24.05.2021 00:00, температура 24) не попадает в historical.
      record.time = Time.local(2021, 'may', 25) - i.hours
      record.temperature = i
      record.save!
    end
  end

  describe '.current' do
    it 'returns temperature of the most recent report' do
      expect(described_class.current).to eq 0
    end
  end

  describe '.historical' do
    it 'returns array of 24 recent reports' do
      expect(described_class.historical).to eq weather_reports[0, 24]
    end
  end

  describe '.historical_max' do
    it 'returns maximum temperature of historical array' do
      expect(described_class.historical_max).to eq 23
    end
  end

  describe '.historical_min' do
    it 'returns minimum temperature of historical array' do
      expect(described_class.historical_min).to eq 0
    end
  end

  describe '.historical_avg' do
    it 'returns average temperature of historical array' do
      expect(described_class.historical_avg).to eq 11.5
    end
  end

  describe '.by_time' do
    it 'returns temperature from the closest to timestamp report' do
      expect(described_class.by_time(1_621_823_790)).to eq 19
    end
  end
end
