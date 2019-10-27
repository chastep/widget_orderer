require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  context 'constants' do
    it { expect(described_class::VALID_COLORS).to be_an(Array) }
  end

  context 'validations and associations' do
    it { expect(subject).to belong_to(:type) }
    it { expect(subject).to validate_inclusion_of(:color).in_array(described_class::VALID_COLORS) }
    [:quantity, :color, :deliver_by, :type_id].each do |field|
      it { expect(subject).to validate_presence_of(field) }
    end
  end
end
