require 'spec_helper'
require './app/models/forecast'

RSpec.describe Forecast do
  xit 'has attributes' do
    title = 'Title'
    owner = 'bob'
    id = '123'
    url = "https://www.flickr.com/photos/#{owner}/#{id}"

    image_details = {
      title: title,
      owner: owner,
      id: id
    }

    background = Forecast.new(image_details)

    expect(background.alt).to eq(title)
    expect(background.url).to eq(url)
  end
end
