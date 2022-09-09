# frozen_string_literal: true

describe AccuWeatherClient do
  describe '#pull_data' do
    context 'initial weather data request' do
      let(:data) { described_class.new.pull_data(initial: true) }

      it 'returns array of hashes with expected keys' do
        VCR.use_cassette('initial_pull_weather_test') do
          expect(data[0].keys).to include('EpochTime', 'Temperature')
        end
      end

      it 'returns array of expected length' do
        VCR.use_cassette('initial_pull_weather_test') do
          expect(data.length).to eq 24
        end
      end
    end

    context 'regular weather data request' do
      let(:data) { described_class.new.pull_data }

      it 'returns array of hashes with expected keys' do
        VCR.use_cassette('regular_pull_weather_test') do
          expect(data[0].keys).to include('EpochTime', 'Temperature')
        end
      end
    end
  end
end
