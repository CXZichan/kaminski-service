class ContactRequestsController < ApplicationController
  MINIMUM_FORM_SECONDS = 3

  def new
    @contact_request = ContactRequest.new(displayed_at: Time.current)
    set_meta(title: "Kontakt | Kaminski Service", description: "Kostenlose und unverbindliche Anfrage an Kaminski Service senden.")
  end

  def create
    @contact_request = ContactRequest.new(contact_request_params)

    if spam_submission?
      @contact_request.errors.add(:base, "Die Anfrage konnte nicht verarbeitet werden. Bitte versuchen Sie es erneut.")
      render_form(:unprocessable_entity)
      return
    end

    if @contact_request.save
      ContactRequestDeliveryJob.perform_later(@contact_request)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contact_path, notice: "Vielen Dank. Ihre Anfrage wurde übermittelt." }
      end
    else
      render_form(:unprocessable_entity)
    end
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(:customer_type, :service, :name, :company, :email, :phone, :postal_code, :city, :message, :displayed_at)
  end

  def spam_submission?
    params[:website].present? || submitted_too_fast?
  end

  def submitted_too_fast?
    displayed_at = Time.zone.parse(contact_request_params[:displayed_at].to_s)
    displayed_at.blank? || displayed_at > MINIMUM_FORM_SECONDS.seconds.ago
  rescue ArgumentError
    true
  end

  def render_form(status)
    respond_to do |format|
      format.turbo_stream { render :create, status: status }
      format.html { render :new, status: status }
    end
  end
end
