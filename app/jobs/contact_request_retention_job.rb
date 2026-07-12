class ContactRequestRetentionJob < ApplicationJob
  queue_as :default

  def perform
    retention_days = ENV.fetch("CONTACT_RETENTION_DAYS", 90).to_i.clamp(1, 3650)
    ContactRequest.ordinary_retention_candidates(retention_days.days.ago).find_each(&:destroy!)
  end
end
