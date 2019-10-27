FactoryBot.define do
  factory :type do
    name { 'widget' }
  end

  trait :pro do
    name { 'widget pro' }
  end

  trait :xtreme do
    name { 'widget xtreme' }
  end
end
