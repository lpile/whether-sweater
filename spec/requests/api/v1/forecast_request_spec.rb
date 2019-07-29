require 'rails_helper'

describe "Forecast API", type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }

  it "returns json weather information for a location" do

    get '/api/v1/forecast?location=denver,co', headers: content_type

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result).to have_key('data')
    expect(result['data']).to have_key('location')
    expect(result['data']).to have_key('currently')
    expect(result['data']).to have_key('hourly')
    expect(result['data']['hourly'].count).to eq(8)
    expect(result['data']).to have_key('daily')
    expect(result['data']['daily'].count).to eq(5)

  end

  it "returns status code 406 if content type is not application/json'" do

    get '/api/v1/forecast?location=denver,co'

    result = JSON.parse(response.body)

    expect(response).to have_http_status(406)
    expect(result).to have_key('error')
    expect(result['error']).to eq('Content-Type must be application/json')

  end
end
