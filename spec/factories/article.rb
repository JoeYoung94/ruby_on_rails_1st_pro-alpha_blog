FactoryGirl.define do
  factory :article do
    title {Faker::Lorem.word}
    description {Faker::Lorem.paragraph(2)}
    association :user
  end
end
