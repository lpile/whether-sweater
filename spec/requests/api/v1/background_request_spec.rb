require 'rails_helper'

describe 'Background API', type: :request do
  it 'returns json array of images with alt and url for a location' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result).to have_key('data')
    expect(result['data'].first).to have_key('id')
    expect(result['data'].first).to have_key('type')
    expect(result['data'].first).to have_key('attributes')
    expect(result['data'].first['attributes']).to have_key('alt')
    expect(result['data'].first['attributes']).to have_key('url')
  end
end
