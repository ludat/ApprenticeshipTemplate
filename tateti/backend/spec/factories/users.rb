FactoryGirl.define do
  factory :user do
    username 'nn'
    password 'pass'
  end
  factory :lucas, class: User do
    username 'lucas'
    password 'password'
  end
  factory :roberto, class: User do
    username 'roberto'
    password '123456'
  end
  factory :juan, class: User do
    username 'juan'
    password 'lelele'
  end
end
