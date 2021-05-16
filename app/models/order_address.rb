class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :municipalities, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  # 復習用→切り取ったバリデーションをここに移動
  with_options presence: true do
    validates :token
    # 復習用→「住所」の郵便番号に関するバリデーション
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :municipalities
    validates :house_number
    validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }
    validates :phone_number, length: { maximum: 11, message: 'Maximum is 11 characters' }
    validates :item_id
    validates :user_id
  end

  # 復習用→ 「住所」の都道府県に関するバリデーション
  with_options numericality: { other_than: 0 } do
    validates :area_id
  end

  def save
    # ユーザーの情報を保存し、「order」という変数に入れている
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(order_id: order.id, postal_code: postal_code, area_id: area_id, municipalities: municipalities,
                   house_number: house_number, building_name: building_name, phone_number: phone_number)
  end
end
