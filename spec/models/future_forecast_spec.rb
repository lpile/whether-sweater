require 'spec_helper'
require './app/models/future_forecast'

RSpec.describe FutureForecast, vcr: { :record => :new_episodes }, type: :model do

  let(:service) { GoogleService.new(address: 'denver, co') }
  let(:road_trip) { service.fetch_duration({origin: 'denver,co', destination: 'new york,ny'}) }
  let(:time) { Time.now.to_i + road_trip[:duration][:value] }
  let(:forecast_details) { DarkSkyService.new(road_trip[:end_location]).fetch_future_forecast(time) }

  it 'has attributes' do
    forecast = FutureForecast.new(forecast_details, road_trip)

    expect(forecast.id).to eq(0)
    expect(forecast.offset).to eq(-4)
    expect(forecast.currently[:location]).to include('New York, NY, USA')
  end
end
