## Users 

|Column            |Type   |Options                 |
|------------------|-------|------------------------|
|nickname          |string |null: false             |
|email             |string |null: false,unique: true|
|encrypted_password|string |null: false             |
|last_name_kanji   |string |null: false             |
|first_name_kanji  |string |null: false             |
|last_name_kana    |string |null: false             |
|first_name_kana   |string |null: false             |
|birthday          |date   |null: false             |

### Association
has_many :orders
has_many :items


## items

|Column         |Type      |Options             |
|---------------|----------|--------------------|
|product_name   |string    |null: false         |：商品名
|explanation    |text      |null: false         |：商品の説明 
|category_id    |integer   |null: false         |：カテゴリー 
|status_id      |integer   |null: false         |：商品の状態
|delivery_fee_id|integer   |null: false         |：配送料の負担
|area_id        |integer   |null: false         |：発送元の地域
|ship_id        |integer   |null: false         |：発送までの日数
|price          |integer   |null: false         |：価格
|user           |references|foreign_key true    |

### Association
belongs_to : user
has_one :order

## orders

|Column |Type     |Options              |
|-------|---------|---------------------|
|user   |reference| foreign_key true    |
|item   |reference| foreign_key true    |

### Association
has_one :address
belongs_to :item
belongs_to :user

## Addresses

|Column        |Type     |Options         |
|--------------|---------|----------------|
|postal_code   |string   |null: false     |：郵便番号
|area_id       |integer  |null: false     |：都道府県 
|municipalities|string   |null: false     |：市区町村 
|house_number  |string   |null: false     |：番地 
|building_name |string   |                |：建物名
|phone_number  |string   |null: false     |：電話番号
|order         |reference|foreign_key true|


### Association
belongs_to :order
