FactoryGirl.define do
  factory :lucas, class: User do
    name 'Lucas Traverso'
    password '123456'
  end
  factory :roberto, class: User do
    name 'Roberto Random'
    password 'password'
  end
end
