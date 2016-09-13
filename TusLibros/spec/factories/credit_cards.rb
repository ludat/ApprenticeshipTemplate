FactoryGirl.define do
  factory :credit_card, class: CreditCard do
    number '1234567890123456'
    expiration_date { 7.days.from_now }
    association :user, factory: :lucas
  end
  factory :expired_credit_card, class: CreditCard do
    number '1234567890123456'
    expiration_date { 7.days.ago }
    association :user, factory: :lucas
  end
end
