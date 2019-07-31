require "rails_helper"

RSpec.describe FlickrService, type: :service do

  let(:service) { FlickrService.new('denver, co') }

  it 'exist' do
    expect(service).to be_a FlickrService
  end

  it '#fetch_images returns an array of locations images' do
    result = service.fetch_images

    expect(result).to have_key(:photos)
    expect(result[:photos]).to have_key(:photo)
  end
end
