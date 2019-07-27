require "rails_helper"

RSpec.describe GoogleService do
  let(:service) { GoogleService.new(address: 'denver, co') }

  it 'exist' do
    expect(service).to be_a GoogleService
  end

  it 'lat_long_search returns locations latitude and longitude' do
    result = service.lat_long_search

    expect(result).to have_key(:lat)
    expect(result).to have_key(:lng)
  end
end
