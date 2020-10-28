require "faker"

FactoryBot.define do
  factory :rate do
    score {Faker::Number.between(from: 1, to: 5)}
    user {FactoryBot.create :user}
    movie {FactoryBot.create :movie}
  end
end
