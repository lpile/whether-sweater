require "rails_helper"

RSpec.describe GoogleService, type: :service do

  let(:service) { GoogleService.new(address: 'denver, co') }

  it 'exist' do
    expect(service).to be_a GoogleService
  end

  it 'fetch_latlong returns locations latitude and longitude' do
    result = service.fetch_latlong

    expect(result).to have_key(:lat)
    expect(result).to have_key(:lng)
  end

  it 'fetch_location returns locations name' do
    result = service.fetch_location

    expect(result).to eq('Denver, CO, USA')
  end

  it 'fetch_duration returns time travel text and unix time' do
    result = service.fetch_duration({origin: 'denver,co', destination: 'pueblo,co'})

    expect(result).to have_key(:distance)
    expect(result).to have_key(:end_address)
    expect(result).to have_key(:end_location)
  end
end
