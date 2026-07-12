require "rails_helper"

RSpec.describe "Rack::Attack", type: :request do
  around do |example|
    Rack::Attack.cache.store.clear
    example.run
    Rack::Attack.cache.store.clear
  end

  it "rate limits repeated contact posts" do
    6.times do
      post contact_requests_path, params: { contact_request: attributes_for(:contact_request, displayed_at: Time.current.iso8601) }
    end

    expect(response).to have_http_status(:too_many_requests)
  end
end
