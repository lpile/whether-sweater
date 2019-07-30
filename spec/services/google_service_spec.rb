require "rails_helper"

RSpec.describe GoogleService, type: :service do
  let(:service) { GoogleService.new(address: 'denver, co') }

  it 'exist' do
    expect(service).to be_a GoogleService
  end

  it 'get_latlong returns locations latitude and longitude' do
    result = service.get_latlong

    expect(result).to have_key(:lat)
    expect(result).to have_key(:lng)
  end

  it 'get_location returns locations name' do
    result = service.get_location

    expect(result).to eq('Denver, CO, USA')
  end

  it 'get_direction returns start location, end location, and time travel' do
    result = service.get_direction({origin: 'denver,co', destination: 'pueblo,co'})

    expect(result).to have_key(:legs)
    expect(result[:legs].first).to have_key(:duration)
  end
end
