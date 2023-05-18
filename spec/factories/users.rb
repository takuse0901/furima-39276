FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    name                  { person.first.kanji }
    sei                   { person.last.kanji }
    kana_name             { person.first.katakana }
    kana_sei              { person.last.katakana }
    birth                 { Faker::Date.birthday }
  end
end
