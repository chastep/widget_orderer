class Order < ApplicationRecord
  VALID_COLORS = ['red', 'yellow', 'blue'].freeze

  belongs_to :type

  validates_presence_of :quantity, :color, :deliver_by, :type_id
  validates :color, inclusion: { in: VALID_COLORS }
  validates :quantity, numericality: {
    greater_than: 0,
    only_integer: true
  }
  validate :deliver_by_date_one_week_away

  # add deliver_by error if date diff is less than 7
  def deliver_by_date_one_week_away
    return unless deliver_by.present?

    errors.add(
      :deliver_by,
      'is not at least 1 week away!'
    ) if ((deliver_by - Time.current)/1.day).round < 7
  end
end
