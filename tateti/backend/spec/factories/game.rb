FactoryGirl.define do
  factory :game do
    association :board, factory: :board
    user { users.first }
  end
end
