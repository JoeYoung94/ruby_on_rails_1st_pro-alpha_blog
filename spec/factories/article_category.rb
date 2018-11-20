FactoryGirl.define do
  factory :article_category do
    article_id {Faker::Number.number(4)}
    category_id {Faker::Number.number(5)}
    association :article
    association :category
  end
end
