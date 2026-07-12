class ServicesController < ApplicationController
  def index
    @services = ServiceCatalog.all
    @contact_request = ContactRequest.new(displayed_at: Time.current)
    set_meta(title: "Leistungen | Kaminski Service", description: "Reinigungsleistungen für Privatkunden, Unternehmen, Praxen und Hausverwaltungen in Celle, Wietze und Umgebung.")
  end

  def show
    @service = ServiceCatalog.find!(params[:slug])
    @contact_request = ContactRequest.new(service: @service.slug, displayed_at: Time.current)
    set_meta(title: "#{@service.title} | Kaminski Service", description: @service.summary)
  end
end
