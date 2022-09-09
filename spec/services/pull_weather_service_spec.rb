# frozen_string_literal: true

describe PullWeatherService do
  let(:client) { instance_double('AccuWeatherClient') }

  before { allow(AccuWeatherClient).to receive(:new).and_return(client) }

  describe '#call' do
    context 'initial weather data creation' do
      before do
        allow(client).to receive(:pull_data).with(initial: true).and_return(Array.new(24) do
                                                                              { 'EpochTime' => 1_621_823_790,
                                                                                'Temperature' => { 'Metric' => { 'Value' => 21 } } }
                                                                            end)
      end

      it 'creates 24 weather reports' do
        expect { described_class.new.call(initial: true) }.to change(WeatherReport, :count).by(24)
      end
    end

    context 'regular weather data creation' do
      before do
        allow(client).to receive(:pull_data).and_return([{ 'EpochTime' => 1_621_823_790,
                                                           'Temperature' => { 'Metric' => { 'Value' => 21 } } }])
      end

      it 'creates a weather report' do
        expect { described_class.new.call }.to change(WeatherReport, :count).by(1)
      end
    end
  end
end
