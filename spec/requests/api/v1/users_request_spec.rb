require 'rails_helper'

describe 'Users API', type: :request do

  let(:content_type) { {'Content-Type': 'application/json', 'Accept': 'application/json'} }
  let(:user1) { {'email': 'whatever@example.com', 'password': 'password', 'password_confirmation': 'password'} }
  let(:user2) { {'email': 'whatever@example.com', 'password': 'password', 'password_confirmation': 'password'} }

  it 'returns json api key to user for registering' do
    post '/api/v1/users', params: user1.to_json, headers: content_type

    expect(response).to be_successful
    expect(response).to have_http_status(:created)

    result = JSON.parse(response.body)

    user_output = User.last

    expect(result).to have_key('api_key')
    expect(result['api_key']).to eq(user_output.api_key)
    expect(user_output.email).to eq(user1[:email])
  end

  it 'returns json error message if user fails to register' do
    post '/api/v1/users', params: user1.to_json, headers: content_type
    post '/api/v1/users', params: user2.to_json, headers: content_type

    expect(response).to have_http_status(406)

    result = JSON.parse(response.body)

    expect(result).to have_key('error')
    expect(result['error']).to eq('Failed to register.')
  end
end
