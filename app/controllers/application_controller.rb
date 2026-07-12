class ApplicationController < ActionController::Base
  before_action :set_company

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern unless Rails.env.test?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :company_config, :consent_categories, :optional_service_enabled?

  private

  def set_company
    @company_config = CompanyConfig.current
  end

  def company_config
    @company_config
  end

  def set_meta(title:, description:)
    @meta_title = title
    @meta_description = description
  end

  def consent_categories
    parsed = JSON.parse(cookies.encrypted[:kaminski_consent].presence || "{}")
    parsed["version"] == ConsentsController::CONSENT_VERSION ? Array(parsed["categories"]) : [ "necessary" ]
  rescue JSON::ParserError
    [ "necessary" ]
  end

  def optional_service_enabled?(category)
    consent_categories.include?(category.to_s) && case category.to_s
                                                  when "statistics" then company_config.feature_enabled?(:analytics)
                                                  when "external_media" then company_config.feature_enabled?(:external_media)
                                                  else false
                                                  end
  end
end
