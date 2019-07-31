require "rails_helper"

RSpec.describe DarkSkyService, type: :service do

  let(:params) { {lat: 39.7392358, lng: -104.990251} }
  let(:service) { DarkSkyService.new(params) }

  it 'exist' do
    expect(service).to be_a DarkSkyService
  end

  it '#fetch_forecast returns locations weather information' do
    result = service.fetch_forecast

    expect(result).to have_key(:currently)
    expect(result).to have_key(:hourly)
    expect(result).to have_key(:daily)
    expect(result).to_not have_key(:minutely)
    expect(result).to_not have_key(:alerts)
    expect(result).to_not have_key(:flags)
  end
end
