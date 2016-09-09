FactoryGirl.define do
  factory :cart do
    association :user, factory: :lucas
  end
end
