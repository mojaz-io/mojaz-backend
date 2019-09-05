FactoryBot.define do
  factory :feed do
    feed_url { Faker::Internet.url }
    title { Faker::Book.title + rand(100).to_s }
    description { Faker::Hipster.paragraph(sentence_count: 1)[0..100] }
    language { "ar" }
  end
end
