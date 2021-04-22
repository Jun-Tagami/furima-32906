FactoryBot.define do
  factory :item do
    product_name           { 'test' }
    explanation            { 'test' }
    category_id            { 2 }
    status_id              { 2 }
    delivery_fee_id        { 2 }
    area_id                { 2 }
    ship_id                { 2 }
    price                  { 400 }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

# ##############以下復習用
# integerは’’いらない
# t.text :product_name, null: false
# t.text :explanation, null: false
# t.integer :category_id
# t.integer :status_id
# t.integer :delivery_fee_id
# t.integer :area_id
# t.integer :ship_id
# t.integer :price
# t.references :user, foreign_key: true
