require 'spec_helper'
require './app/models/background_image'

RSpec.describe BackgroundImage, vcr: { :record => :new_episodes }, type: :model do

  let(:service) { FlickrService.new('denver,co') }
  let(:image) { service.fetch_images[:photos][:photo].first }
  let(:url) { "https://www.flickr.com/photos/#{image[:owner]}/#{image[:id]}" }

  it 'has attributes' do
    background = BackgroundImage.new(image)

    expect(background.alt).to eq(image[:title])
    expect(background.url).to eq(url)
  end
end
