FactoryGirl.define do
  factory :credit_card do
    number '1234567890123456'
    expiration_date { 7.days.from_now }
    association :user, factory: :lucas
  end
end
