FactoryGirl.define do
  factory :user do
    name { Faker::Name.unique.first_name.strip }
    phone_number { Faker::Number.number(digits: 10) }
    password { Faker::Internet.password }
    role_id { Faker::Number.between(from: 1, to: 2) }
  end
end
