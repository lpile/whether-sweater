require 'rails_helper'

describe "Forecast API", type: :request do
  it "returns json weather information for a location" do

    get '/api/v1/forecast?location=denver,co'

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
end
