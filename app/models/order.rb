class Order < ApplicationRecord
  include AASM

  VALID_COLORS = ['red', 'yellow', 'blue'].freeze

  attr_readonly :uuid

  belongs_to :type

  validates_presence_of :quantity, :color, :deliver_by, :type_id, :status
  validates_uniqueness_of :uuid
  validates :color, inclusion: { in: VALID_COLORS }
  validates :quantity, numericality: {
    greater_than: 0,
    only_integer: true
  }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate :deliver_by_date_one_week_away
  validate :prevent_update_if_uuid_present

  before_create :assign_order_id

  aasm column: :status do
    state :pending, initial: true
    state :shipped
    state :completed

    event :ship do
      transitions from: :pending, to: :shipped
    end

    event :complete do
      transitions from: :shipped, to: :completed
    end
  end

  # add deliver_by error if date diff is less than 7
  def deliver_by_date_one_week_away
    return unless deliver_by.present?

    errors.add(
      :deliver_by,
      'is not at least 1 week away!'
    ) if ((deliver_by - Time.current)/1.day).round < 7
  end

  def assign_order_id
    self.uuid ||= SecureRandom.uuid
  end

  def prevent_update_if_uuid_present
    errors.add(
      :uuid,
      'cannot be updated!'
    ) if uuid_changed? && self.persisted?
  end
end
