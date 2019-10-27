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

    context 'deliver by date validation' do
      it 'vaidates that deliver by date is at least 1 week away' do
        subject.deliver_by = Time.current + 3.days
        expect(subject.valid?).to be(false)
      end

      it 'vaidates that deliver by date is not in the future' do
        subject.deliver_by = Time.current - 2.weeks
        expect(subject.valid?).to be(false)
      end
    end
  end
end
