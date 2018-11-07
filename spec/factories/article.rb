FactoryGirl.define do
  factory :article do
    title {Faker::Name}
    description {Faker::String}
    user_id {Faker::Number.digit}
  end
end
