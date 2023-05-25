FactoryBot.define do
  factory :order_address do
    postcode      { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { '〇〇市' }
    address       { '〇〇番地' }
    building_name { '〇〇マンション' }
    tel           { '09012345678' }
  end
end
