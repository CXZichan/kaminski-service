class SiteLegalCheck
  attr_reader :errors

  def initialize(config = CompanyConfig.current)
    @config = config
    @errors = []
    run
  end

  private

  def run
    errors.concat(config.placeholders.keys.map { |key| "Platzhalter vorhanden: #{key}" })
    errors.concat(config.missing_legal_fields.map { |key| "Pflichtangabe fehlt: #{key}" })
    check_feature_consistency
    check_routes
    check_forbidden_os_link
  end

  attr_reader :config

  def check_feature_consistency
    errors << "Analytics aktiviert, aber Datenschutzabschnitt ist noch TODO." if config.feature_enabled?(:analytics)
    errors << "Externe Medien aktiviert, aber Datenschutzabschnitt ist noch TODO." if config.feature_enabled?(:external_media)
    errors << "Eingebettete Karten aktiviert, aber externe Medien/Consent nicht konsistent." if config.feature_enabled?(:embedded_maps) && !config.feature_enabled?(:external_media)
  end

  def check_routes
    Rails.application.routes.url_helpers.tap do |routes|
      [ routes.imprint_path, routes.privacy_path, routes.cookie_settings_path ].each do |path|
        errors << "Rechtliche Route fehlt: #{path}" unless Rails.application.routes.recognize_path(path)
      rescue ActionController::RoutingError
        errors << "Rechtliche Route fehlt: #{path}"
      end
    end
  end

  def check_forbidden_os_link
    files = Rails.root.glob("app/views/**/*").select(&:file?)
    errors << "Veralteter EU-OS-Plattform-Link gefunden." if files.any? { |file| file.read.include?("ec.europa.eu/consumers/odr") }
  end
end
