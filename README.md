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

|Column      |Type     |Options             |
|---------------|---------|--------------------|
|product_name   |string   |null: false         |
|explanation    |text     |null: false         |
|category_id    |integer  |null: false         |
|status_id      |integer  |null: false         |
|delivery_fee_id|integer  |null: false         |
|area_id        |integer  |null: false         |
|ship_id        |integer  |null: false         |
|price          |integer  |null: false         |
|user           |reference|foreignkey_key true |

### Association
belongs_to : user,order


## orders

|Column |Type     |Options              |
|-------|---------|---------------------|
|user   |reference| foreignkey_key true |
|irem   |regerence| foreignkey_key true |

### Association
belongs_to :address,item,user


## Addresses

|Column        |Type     |Options         |
|--------------|---------|----------------|
|postal_code   |string   |null: false     |
|area_id       |integer  |null: false     |
|municipalities|string   |null: false     |
|house_number  |string   |null: false     |
|building_name |string   |                |
|phone_number  |string   |null: false     |
|user          |reference|foreign_key true|
|item          |reference|foreign_key true|

### Association
belongs_to :order