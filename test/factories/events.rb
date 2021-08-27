FactoryBot.define do
  factory :event do
    owner
    sequence(:name) { |i| "name#{i}" }
    sequence(:place) { |i| "イベント開催場所#{i}" }
    sequence(:content) { |i| "イベント本文#{i}" }
    start_at { rand(1..30).days.from_now }
    end_at { start_at + rand(1..30).hours }
  end
end
