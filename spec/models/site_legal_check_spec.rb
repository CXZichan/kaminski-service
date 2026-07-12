require "rails_helper"

RSpec.describe SiteLegalCheck do
  it "detects placeholders" do
    expect(described_class.new.errors).to include(a_string_including("Platzhalter"))
  end

  it "detects forbidden old OS platform links" do
    fake_file = instance_double(Pathname, file?: true, read: "https://ec.europa.eu/consumers/odr")
    allow(Rails.root).to receive(:glob).and_return([ fake_file ])

    expect(described_class.new.errors).to include("Veralteter EU-OS-Plattform-Link gefunden.")
  end
end
