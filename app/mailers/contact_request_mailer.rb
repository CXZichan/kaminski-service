class ContactRequestMailer < ApplicationMailer
  def new_request(contact_request)
    @contact_request = contact_request
    mail(
      to: ENV.fetch("CONTACT_RECIPIENT_EMAIL", CompanyConfig.current.contact_email),
      from: ENV.fetch("DEFAULT_FROM_EMAIL", "website@kaminski-service.de"),
      subject: "Neue Anfrage über kaminski-service.de"
    )
  end
end
