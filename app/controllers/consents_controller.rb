class ConsentsController < ApplicationController
  CONSENT_VERSION = "2026-07-13".freeze

  def settings
    set_meta(title: "Cookie-Einstellungen | Kaminski Service", description: "Datenschutzfreundliche Einstellungen für notwendige Cookies, Statistik und externe Medien.")
  end

  def update
    cookies.encrypted[:kaminski_consent] = {
      value: { version: CONSENT_VERSION, categories: permitted_categories, decided_at: Time.current.iso8601 }.to_json,
      same_site: :lax,
      httponly: true,
      expires: 1.year.from_now
    }
    redirect_back fallback_location: root_path, notice: "Ihre Cookie-Einstellungen wurden gespeichert."
  end

  private

  def permitted_categories
    selected = Array(params[:categories]).map(&:to_s) & %w[statistics external_media]
    [ "necessary", *selected ]
  end
end
