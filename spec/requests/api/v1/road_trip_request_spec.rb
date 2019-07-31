require 'rails_helper'

describe 'RoadTrip API', :vcr, type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { User.create!(email: 'whatever@example.com', password: 'password', password_confirmation: 'password') }
  let(:body) { {'origin': 'Denver,CO', 'destination': 'Pueblo,CO', 'api_key': user.api_key} }
  let(:error) { {'origin': 'Denver,CO', 'destination': 'Pueblo,CO'} }

  it 'returns json future forecast information of end destination' do
    expect(user.api_key).to eq(body[:api_key])

    post '/api/v1/road_trip', params: body.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    result = JSON.parse(response.body)

    expect(result).to have_key('data')
    expect(result['data']).to have_key('attributes')
    expect(result['data']['attributes']).to have_key('currently')
    expect(result['data']['attributes']['currently']['location']).to eq('Pueblo, CO, USA')
    expect(result['data']['attributes']['currently']['estimated_travel_time']).to eq('1 hour 47 mins')
  end

  it 'returns returns json error message if theres no api key' do
    post '/api/v1/road_trip', params: error.to_json, headers: content_type

    expect(response).to have_http_status(401)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('No api key.')
  end
end
