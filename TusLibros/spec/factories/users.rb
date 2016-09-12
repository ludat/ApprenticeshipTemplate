FactoryGirl.define do
  factory :lucas, class: User do
    username 'ludat'
    password '123456'
  end
  factory :roberto, class: User do
    username 'roberto_random'
    password 'password'
  end
end
