FactoryBot.define do
  factory :order do
    sequence(:quantity) { |n| n }
    color { Order::VALID_COLORS.sample }
    deliver_by { Date.today + 2.weeks }
    type
  end
end
