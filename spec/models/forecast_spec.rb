require 'spec_helper'
require './app/models/forecast'

RSpec.describe Forecast, vcr: { :record => :new_episodes }, type: :model do

  let(:service) { GoogleService.new(address: 'denver, co') }
  let(:lat_long) { service.fetch_latlong }
  let(:location) { service.fetch_location }
  let(:forecast_details) { DarkSkyService.new(lat_long).fetch_forecast }

  it 'has attributes' do
    forecast = Forecast.new(forecast_details, location)

    expect(forecast.id).to eq(0)
    expect(forecast.offset).to eq(-6)
    expect(forecast.location).to eq('Denver, CO, USA')
    expect(forecast.hourly_data.count).to eq(8)
    expect(forecast.daily_data.count).to eq(6)
    expect(forecast.currently).to have_key(:time)
    expect(forecast.hourly.first).to have_key(:time)
    expect(forecast.daily.first).to have_key(:time)
    expect(forecast.hourly.class).to eq(Array)
    expect(forecast.daily.class).to eq(Array)
  end
end
