class Type < ApplicationRecord
  VALID_WIDGET_TYPES = ['widget', 'widget pro', 'widget xtreme'].freeze

  has_many :orders

  validates_presence_of :name
  validates :name, inclusion: { in: VALID_WIDGET_TYPES }

  def offical_name
    name.split.map(&:capitalize)*' '
  end
end
