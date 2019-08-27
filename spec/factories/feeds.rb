FactoryBot.define do
  factory :feed do
    url { Faker::Internet.url }
    title { Faker::Book.title + rand(100).to_s }
    description { Faker::Hipster.paragraph(sentence_count: 1)[0..100] }
    language { "en" }
  end
end