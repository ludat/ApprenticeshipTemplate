FactoryGirl.define do
  factory :cart_session do
    association :cart, factory: :cart
    association :user, factory: :lucas
  end
end
