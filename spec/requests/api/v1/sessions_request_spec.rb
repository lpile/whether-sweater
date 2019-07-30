require 'rails_helper'

describe 'Sessions API', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user) { {'email': 'whatever@example.com', 'password': 'password'} }

  it 'returns json api key to user for logging in' do

    User.create!(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')

    post '/api/v1/sessions', params: user.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    result = JSON.parse(response.body)

    user_output = User.last

    expect(result).to have_key('api_key')
    expect(result['api_key']).to eq(user_output.api_key)
    expect(user_output.email).to eq(user[:email])

  end

  it 'returns json error message if user fails to register' do

    post '/api/v1/sessions', params: user.to_json, headers: content_type

    expect(response).to have_http_status(406)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to login.')

  end
end
