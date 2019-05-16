FactoryBot.define do
  factory :gist do
    association :author, factory: :user
  end
end
