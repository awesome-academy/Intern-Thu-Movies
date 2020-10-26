require "faker"

FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"nguyenvanthu"}
    password_digest {"nguyenvanthu"}
    role {Faker::Number.between from: 0, to: 1}
  end
end
