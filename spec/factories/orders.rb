FactoryBot.define do
  factory :order do
    sequence(:quantity) { |n| n }
    color { Order::VALID_COLORS.sample }
    deliver_by { Time.current + 1.week }
    type
  end
end
