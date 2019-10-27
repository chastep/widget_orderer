require 'rails_helper'

RSpec.describe Type, type: :model do
  subject { create(:type) }

  context 'constants' do
    it { expect(described_class::VALID_WIDGET_TYPES).to be_an(Array) }
  end

  context 'validations and associations' do
    it { expect(subject).to have_many(:orders) }
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_inclusion_of(:name).in_array(described_class::VALID_WIDGET_TYPES) }
  end
end
