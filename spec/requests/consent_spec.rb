require "rails_helper"

RSpec.describe "Consent", type: :request do
  it "stores necessary-only consent" do
    post consent_path, params: { categories: [] }, headers: { "HTTP_REFERER" => root_url }

    expect(response).to redirect_to(root_path)
    expect(cookies[:kaminski_consent]).to be_present
  end

  it "loads cookie settings from footer route" do
    get cookie_settings_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Cookie-Einstellungen")
  end
end
