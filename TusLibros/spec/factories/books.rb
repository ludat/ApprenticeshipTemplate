FactoryGirl.define do
  factory :harry_potter, class: Book do
    icbn '123456789'
    title 'Harry Potter'
    price 10
  end

  factory :lotr, class: Book do
    icbn '987654321'
    title 'Lord of The Rings'
    price 25
  end
end
