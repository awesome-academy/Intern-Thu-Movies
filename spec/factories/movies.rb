require "faker"

FactoryBot.define do
  factory :movie do
    title {Faker::Movie.title}
    image {Rack::Test::UploadedFile.new "#{Rails.root}/spec/files/mulan.jpg"}
    slug {"test"}
    runtime {"1h5m"}
    genre {FactoryBot.create :genre}
    overview {Faker::Lorem.sentence(word_count: 10)}
    trailer {"youtube"}
  end
end
