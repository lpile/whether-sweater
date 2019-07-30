require 'rails_helper'

describe "Backgrounds API", type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }

  it "returns json image url for a location" do

    get '/api/v1/backgrounds?location=denver,co', headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result).to have_key('data')
    expect(result['data']).to have_key('image_url')

  end
end
