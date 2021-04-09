FactoryBot.define do
  factory :user do
    nickname               { Faker::Name.initials(number: 2) }
    email                  { Faker::Internet.free_email }
    password               { '1a' + Faker::Internet.password(min_length: 3) }
    password_confirmation  { password }
    last_name_kanji        { '山田' }
    first_name_kanji       { '太郎' }
    last_name_kana         { 'ヤマダ' }
    first_name_kana        { 'タロウ' }
    birthday               { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end