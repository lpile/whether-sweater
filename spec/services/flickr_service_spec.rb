require "rails_helper"

RSpec.describe FlickrService, type: :service do
  let(:service) { FlickrService.new }

  it 'exist' do
    expect(service).to be_a FlickrService
  end

  it 'find_image returns top rated image' do
    result = service.find_image_id('denver, co')

    expect(result).to eq('16692009314')
  end

  it 'get_image returns images url' do
    result = service.get_image_info('16692009314')

    expect(result).to eq('https://www.flickr.com/photos/onasill/16692009314/')
  end
end
