require 'rails_helper'

describe "Weather API" do
  it "sends lat and long for location" do

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
