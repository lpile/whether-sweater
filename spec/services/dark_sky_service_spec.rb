require "rails_helper"

RSpec.describe DarkSkyService, type: :service do
  let(:params) { {lat: 39.7392358, lng: -104.990251} }
  let(:service) { DarkSkyService.new(params) }

  it 'exist' do
    expect(service).to be_a DarkSkyService
  end

  it 'get_weather returns locations weather information' do
    result = service.get_weather

    expect(result).to have_key(:currently)
    expect(result).to have_key(:hourly)
    expect(result).to have_key(:daily)
  end
end
