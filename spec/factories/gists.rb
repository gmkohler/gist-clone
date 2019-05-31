FactoryBot.define do
  factory :gist do
    association :author, factory: :user

    private_gist { true }
    description { Faker::Lorem.sentence (3..10).to_a.sample }
    title { Faker::Lorem.word }

    trait :public do
      private_gist { false }
    end
  end
end
