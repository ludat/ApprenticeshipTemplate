FactoryGirl.define do
  factory :harry_potter, class: Book do
    isbn '123456789'
    title 'Harry Potter'
    price 10
  end

  factory :lotr, class: Book do
    isbn '987654321'
    title 'Lord of The Rings'
    price 25
  end
end
