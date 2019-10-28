require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  describe 'constants' do
    it { expect(described_class::VALID_COLORS).to be_an(Array) }
  end

  describe 'validations and associations' do
    it { expect(subject).to belong_to(:type) }
    it { expect(subject).to validate_inclusion_of(:color).in_array(described_class::VALID_COLORS) }
    [:quantity, :color, :deliver_by, :type_id, :status].each do |field|
      it { expect(subject).to validate_presence_of(field) }
    end
    it { expect(subject).to validate_uniqueness_of(:uuid) }
    it { expect(subject).to validate_numericality_of(:quantity).is_greater_than(0) }
    it { expect(subject).to validate_numericality_of(:quantity).only_integer }
    it { is_expected.to allow_value("email@address.foo").for(:email) }
    it { is_expected.to_not allow_value("foo").for(:email) }

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

    context 'dont allow uuid to be updated' do
      it 'by being set to any other value' do
        subject.uuid = SecureRandom.uuid
        expect(subject.valid?).to be(false)
      end

      it 'by being set to nil' do
        subject.uuid = nil
        expect(subject.valid?).to be(false)
      end
    end
  end

  describe 'status functionality' do
    describe '#process' do
      it 'when order is pending' do
        subject.process

        expect(subject.status.to_s).to eq('processing')
      end

      context 'when order is completed' do
        let(:completed_order) { create(:order, status: 'completed') }

        it { expect{completed_order.process}.to raise_error(AASM::InvalidTransition) }
      end
    end

    describe '#complete' do
      context 'when order is pending' do
        let(:processing_order) { create(:order, status: 'processing') }
        before { processing_order.complete }

        it { expect(processing_order.status.to_s).to eq('completed') }
      end

      context 'when order is pending' do
        it { expect{subject.complete}.to raise_error(AASM::InvalidTransition) }
      end
    end
  end
end
