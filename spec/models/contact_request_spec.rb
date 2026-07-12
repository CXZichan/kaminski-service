require "rails_helper"

RSpec.describe ContactRequest, type: :model do
  it "normalizes email and phone" do
    request = build(:contact_request, email: " MAX@EXAMPLE.COM ", phone: "+49<script>511")

    request.validate

    expect(request.email).to eq("max@example.com")
    expect(request.phone).to eq("+49511")
  end

  it "rejects header injection in email" do
    request = build(:contact_request, email: "test@example.com\nbcc@example.com")

    expect(request).not_to be_valid
  end
end
