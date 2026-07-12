class PagesController < ApplicationController
  def home
    @contact_request = ContactRequest.new(displayed_at: Time.current)
    @services = ServiceCatalog.all
    @faqs = SiteContent.faqs
    @references = SiteContent.references
    set_meta(
      title: "Kaminski Service | Gebäudereinigung in Celle und Wietze",
      description: "Gebäudereinigung, Büroreinigung, Glasreinigung und Sonderreinigung für private und gewerbliche Objekte in Celle, Wietze und Umgebung."
    )
  end

  def about
    set_meta(title: "Über uns | Kaminski Service", description: "Kaminski Service aus Wietze: Reinigungsservice für Celle, Wietze und Umgebung.")
  end
end
