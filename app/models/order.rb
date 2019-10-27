class Order < ApplicationRecord
  VALID_COLORS = ['red', 'yellow', 'blue'].freeze

  belongs_to :type

  validates_presence_of :quantity, :color, :deliver_by, :type_id
  validates :color, inclusion: { in: VALID_COLORS }
end
