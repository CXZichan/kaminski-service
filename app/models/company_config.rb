class CompanyConfig
  REQUIRED_LEGAL_KEYS = %w[
    company.legal_name
    company.legal_form
    company.representative
    company.street
    company.postal_code
    company.city
    contact.email
    hosting.provider_name
    email_provider.provider_name
  ].freeze

  def self.current
    @current ||= new(YAML.safe_load_file(Rails.root.join("config/company.yml"), aliases: true).deep_stringify_keys)
  end

  def initialize(data)
    @data = data
  end

  def dig(*keys)
    @data.dig(*keys.map(&:to_s))
  end

  def company
    @data.fetch("company")
  end

  def contact
    @data.fetch("contact")
  end

  def business
    @data.fetch("business")
  end

  def service_area
    @data.fetch("service_area")
  end

  def hosting
    @data.fetch("hosting")
  end

  def email_provider
    @data.fetch("email_provider")
  end

  def features
    @data.fetch("features")
  end

  def display_name
    company.fetch("display_name")
  end

  def contact_email
    contact.fetch("email")
  end

  def phone
    contact["phone"]
  end

  def full_address
    [ company["street"], [ company["postal_code"], company["city"] ].compact.join(" "), company["country"] ].compact_blank.join(", ")
  end

  def route_url
    "https://www.google.com/maps/search/?api=1&query=#{CGI.escape(full_address)}"
  end

  def feature_enabled?(name)
    ActiveModel::Type::Boolean.new.cast(features[name.to_s]) || ActiveModel::Type::Boolean.new.cast(ENV["ENABLE_#{name.to_s.upcase}"])
  end

  def placeholders
    flatten(@data).select { |_key, value| value.to_s.include?("[BITTE EINTRAGEN]") }
  end

  def missing_legal_fields
    REQUIRED_LEGAL_KEYS.select { |key| blank_or_placeholder?(key.split(".").reduce(@data) { |node, part| node&.[](part) }) }
  end

  def local_business_ready?
    missing_legal_fields.empty? && phone.present?
  end

  private

  def blank_or_placeholder?(value)
    value.blank? || value.to_s.include?("[BITTE EINTRAGEN]")
  end

  def flatten(hash, prefix = nil)
    hash.each_with_object({}) do |(key, value), result|
      path = [ prefix, key ].compact.join(".")
      if value.is_a?(Hash)
        result.merge!(flatten(value, path))
      else
        result[path] = value
      end
    end
  end
end
