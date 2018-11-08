FactoryGirl.define do
  factory :user do
    username {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Lorem.word}
    admin {Faker::Boolean.boolean(0.2)}
  end
end
