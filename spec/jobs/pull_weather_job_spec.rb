# frozen_string_literal: true

describe PullWeatherJob, type: :job do
  let(:service) { instance_double('PullWeatherService') }

  before { allow(PullWeatherService).to receive(:new).and_return(service) }

  it 'calls PullWeather#call' do
    expect(service).to receive(:call)
    PullWeatherJob.perform_now
  end
end
