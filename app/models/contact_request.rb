class ContactRequest < ApplicationRecord
  PRIVACY_NOTICE_VERSION = "2026-07-13".freeze
  CUSTOMER_TYPES = %w[private business].freeze
  STATUSES = %w[pending delivered failed archived].freeze

  encrypts :name
  encrypts :company
  encrypts :email, deterministic: true, downcase: true
  encrypts :phone
  encrypts :postal_code
  encrypts :city
  encrypts :message

  before_validation :normalize_fields
  before_validation :assign_defaults

  validates :customer_type, inclusion: { in: CUSTOMER_TYPES }
  validates :service, inclusion: { in: ServiceCatalog.all.map(&:slug) }
  validates :status, inclusion: { in: STATUSES }
  validates :name, :email, :postal_code, :city, :message, presence: true
  validates :name, :company, :city, length: { maximum: 120 }
  validates :email, length: { maximum: 160 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, :postal_code, length: { maximum: 40 }
  validates :message, length: { maximum: 2_000 }
  validate :email_has_no_header_injection

  scope :ordinary_retention_candidates, ->(before_time) { where("created_at < ?", before_time).where.not(status: "archived") }

  def delivered!
    update!(status: "delivered", delivered_at: Time.current, failed_at: nil)
  end

  def failed!
    update!(status: "failed", failed_at: Time.current)
  end

  def service_label
    ServiceCatalog.find!(service).title
  rescue ActiveRecord::RecordNotFound
    service
  end

  private

  def normalize_fields
    self.email = email.to_s.strip.downcase
    self.phone = phone.to_s.gsub(/[^\d+()\s.-]/, "").squish.presence
    self.name = name.to_s.squish
    self.company = company.to_s.squish.presence
    self.postal_code = postal_code.to_s.squish
    self.city = city.to_s.squish
    self.message = message.to_s.strip
  end

  def assign_defaults
    self.status ||= "pending"
    self.privacy_notice_version ||= PRIVACY_NOTICE_VERSION
  end

  def email_has_no_header_injection
    errors.add(:email, "enthält ungültige Zeichen") if email.to_s.match?(/[\r\n]/)
  end
end
