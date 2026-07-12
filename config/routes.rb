Rails.application.routes.draw do
  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  get "leistungen", to: "services#index", as: :services
  get "leistungen/:slug", to: "services#show", as: :service
  get "ueber-uns", to: "pages#about", as: :about
  get "kontakt", to: "contact_requests#new", as: :contact
  post "kontakt", to: "contact_requests#create", as: :contact_requests
  get "impressum", to: "legal#imprint", as: :imprint
  get "datenschutz", to: "legal#privacy", as: :privacy
  get "cookie-einstellungen", to: "consents#settings", as: :cookie_settings
  post "cookie-einstellungen", to: "consents#update", as: :consent
  get "sitemap.xml", to: "seo#sitemap", defaults: { format: :xml }
end
