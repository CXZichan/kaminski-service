class ContactRequestDeliveryJob < ApplicationJob
  queue_as :default

  retry_on Net::SMTPServerBusy, Net::SMTPUnknownError, wait: :polynomially_longer, attempts: 5
  discard_on ActiveJob::DeserializationError

  def perform(contact_request)
    ContactRequestMailer.new_request(contact_request).deliver_now
    contact_request.delivered!
  rescue StandardError
    contact_request.failed!
    raise
  end
end
