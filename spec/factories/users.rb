FactoryBot.define do
  factory :user do
    display_name { Faker::Name.name }
    handle { Faker::Internet.username }
    password { Faker::Internet.password }
  end
end
