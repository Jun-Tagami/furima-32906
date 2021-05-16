FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code               { '111-1111' }
    area_id                   { 2 }
    municipalities            { '藤沢市' }
    house_number              { '400' }
    building_name             { '建物名' }
    phone_number              { '07012345678' }
  end
end
