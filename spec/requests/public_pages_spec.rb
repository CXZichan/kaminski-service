require "rails_helper"

RSpec.describe "Public pages", type: :request do
  it "loads the homepage" do
    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Keine Zeit für gründliche Reinigung? Wir kümmern uns darum.")
    expect(response.body).to include("Unverbindliche Anfrage stellen")
  end

  it "loads service pages" do
    ServiceCatalog.all.each do |service|
      get service_path(service.slug)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(service.title)
    end
  end

  it "loads legal pages" do
    get imprint_path
    expect(response).to have_http_status(:ok)

    get privacy_path
    expect(response).to have_http_status(:ok)
  end

  it "does not render optional services without consent" do
    get root_path

    expect(response.body).not_to include("Google Analytics")
    expect(response.body).not_to include("iframe")
  end
end
