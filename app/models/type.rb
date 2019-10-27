class Type < ApplicationRecord
  VALID_WIDGET_TYPES = ['widget', 'widget pro', 'widget xtreme'].freeze

  has_many :orders

  validates_presence_of :name
  validates :name, inclusion: { in: VALID_WIDGET_TYPES }
end
