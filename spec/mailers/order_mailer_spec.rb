require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:order) { create(:order, email: 'test@email.com') }

  describe '.create_order' do
    let!(:email) { OrderMailer.create_order(order.id, order.email).deliver }

    it { expect(email.to).to eq([order.email]) }
    it { expect(email.subject).to eq('Order Created!') }
    it { expect(email.body.encoded).to include(order.uuid) }
    it { expect(ActionMailer::Base.deliveries).not_to be_empty }
  end
end
