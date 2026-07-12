require "rails_helper"

RSpec.describe "filtered parameters" do
  it "filters sensitive contact form keys" do
    filters = Rails.application.config.filter_parameters

    expect(filters).to include(:name, :email, :phone, :postal_code, :city, :message, :contact_request)
  end
end
