FactoryBot.define do
  factory :contact_request do
    customer_type { "business" }
    service { "bueroreinigung" }
    name { "Max Muster" }
    company { "Muster GmbH" }
    email { "max@example.com" }
    phone { "+49 511 123456" }
    postal_code { "30159" }
    city { "Hannover" }
    message { "Bitte senden Sie uns ein Angebot." }
    status { "pending" }
    privacy_notice_version { ContactRequest::PRIVACY_NOTICE_VERSION }
    displayed_at { 10.seconds.ago }
  end
end
