class SeoController < ApplicationController
  def sitemap
    @urls = [
      root_url,
      services_url,
      about_url,
      contact_url,
      imprint_url,
      privacy_url,
      cookie_settings_url,
      *ServiceCatalog.all.map { |service| service_url(service.slug) }
    ]
  end
end
