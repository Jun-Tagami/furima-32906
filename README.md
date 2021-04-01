## Users 

|Column          |Type   |Options    |
|----------------|-------|-----------|
|nickname        |string |null: false|
|mailaddress     |string |null: false|
|password        |string |null: false|
|last_name_kanji |string |null: false|
|first_name_kanji|string |null: false|
|last_name_kana  |string |null: false|
|first_name_kana |string |null: false|
|year_birth      |integer|null: false|
|month_birth     |integer|null: false|
|day_birth       |integer|null: false|

### Association
belongs_to :order
has_many :items


## items

|Column      |Type     |Options             |
|------------|---------|--------------------|
|image       |         |active strageで実装  |
|product_name|text     |null: false         |
|explanation |text     |null: false         |
|category    |integer  |null: false         |
|status      |integer  |null: false         |
|delivery_fee|integer  |null: false         |
|area        |integer  |null: false         |
|ship        |integer  |null: false         |
|price       |integer  |null: false         |
|user        |reference|foreignkey_key true |

### Association
belongs_to : user,order


## orders

|Column |Type     |Options              |
|-------|---------|---------------------|
|user_id|reference| foreignkey_key true |
|irem_id|regerence| foreignkey_key true |

### Association
belongs_to :address,item,user


## Addresses

|Column        |Type     |Options            |
|--------------|---------|-------------------|
|postal_code   |string   |null: false        |
|prefecture    |integer  |null: false        |
|municipalities|string   |null: false        |
|house_number  |string   |null: false        |
|building_name |string   |                   |
|phone_number  |string   |null: false        |
|user_id       |reference|foreignkey_key true|
|irem_id       |regerence|foreignkey_key true|

### Association
belongs_to :order