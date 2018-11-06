FactoryGirl.define do
  factory :article do
    title {Faker::String.random(3..25)}
    description {Faker::String.random(10..30)}
    user_id {Faker::Number.digit}
  end
end
