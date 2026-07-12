class LegalController < ApplicationController
  def imprint
    set_meta(title: "Impressum | Kaminski Service", description: "Anbieterkennzeichnung nach § 5 DDG für Kaminski Service.")
  end

  def privacy
    set_meta(title: "Datenschutzerklärung | Kaminski Service", description: "Informationen zur Verarbeitung personenbezogener Daten auf dieser Website.")
  end
end
