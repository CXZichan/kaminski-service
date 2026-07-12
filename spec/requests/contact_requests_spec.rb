require "rails_helper"

RSpec.describe "Contact requests", type: :request do
  include ActiveJob::TestHelper

  let(:valid_params) do
    {
      contact_request: attributes_for(:contact_request, displayed_at: 10.seconds.ago.iso8601)
    }
  end

  it "validates required fields" do
    post contact_requests_path, params: { contact_request: { displayed_at: 10.seconds.ago.iso8601 } }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include("Bitte prüfen Sie")
  end

  it "stores a valid request and enqueues delivery" do
    expect {
      post contact_requests_path, params: valid_params
    }.to change(ContactRequest, :count).by(1)
      .and have_enqueued_job(ContactRequestDeliveryJob)

    expect(response).to redirect_to(contact_path)
  end

  it "blocks honeypot spam" do
    expect {
      post contact_requests_path, params: valid_params.merge(website: "spam")
    }.not_to change(ContactRequest, :count)

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "blocks too fast submissions" do
    params = valid_params.deep_dup
    params[:contact_request][:displayed_at] = Time.current.iso8601

    expect {
      post contact_requests_path, params: params
    }.not_to change(ContactRequest, :count)
  end
end
