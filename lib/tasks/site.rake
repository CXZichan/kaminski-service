namespace :site do
  desc "Prüft rechtliche Go-live-Voraussetzungen und Feature/Consent-Konsistenz"
  task legal_check: :environment do
    checker = SiteLegalCheck.new
    checker.errors.each { |error| warn "LEGAL CHECK: #{error}" }

    if checker.errors.any? && ActiveModel::Type::Boolean.new.cast(ENV.fetch("LEGAL_RELEASE_READY", false))
      abort "Legal-Check fehlgeschlagen. LEGAL_RELEASE_READY=true erlaubt keine offenen Punkte."
    end

    puts checker.errors.any? ? "Legal-Check mit Warnungen abgeschlossen." : "Legal-Check erfolgreich."
  end
end
