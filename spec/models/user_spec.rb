require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.login_valid?' do
    context 'valid admin credentials' do
      user = User.new(username: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'])

      it { expect(user.login_valid?).to be(true) }
    end

    context 'invalid admin credentials' do
      user = User.new(username: 'foo', password: 'bar')

      it { expect(user.login_valid?).to be(false) }
    end
  end
end
