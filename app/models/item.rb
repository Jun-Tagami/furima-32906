class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :area
  belongs_to :ship

  belongs_to :user

  with_options presence: true do
    validates :product_name
    validates :explanation
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :area_id
    validates :ship_id
  end

  validates :price, numericality: { greater_than: 299, less_than: 10_000_000 }
  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }

end

###########以下復習用
  # - 商品名が必須であること
  # 商品の説明が必須であること
  # - カテゴリーの情報が必須であること
  # - 商品の状態についての情報が必須であること
  # - 配送料の負担についての情報が必須であること
  # - 発送元の地域についての情報が必須であること
  # - 発送までの日数についての情報が必須であること
  # - 価格についての情報が必須であること
  # 価格の範囲が、¥300~¥9,999,999の間であること
  # 販売価格は半角数字のみ保存可能であること
  # ジャンルの選択が「--」の時は保存できないようにする
  # - ログイン状態のユーザーだけが、商品出品ページへ遷移できること
  # - ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移すること
  # - 商品画像を1枚つけることが必須であること
  # - 商品名が必須であること
  # - 商品の説明が必須であること
  # - カテゴリーの情報が必須であること
  # - 商品の状態についての情報が必須であること
  # - 配送料の負担についての情報が必須であること
  # - 発送元の地域についての情報が必須であること
  # - 発送までの日数についての情報が必須であること
  # - 価格についての情報が必須であること
  # - 価格の範囲が、¥300~¥9,999,999の間であること
  # - 販売価格は半角数字のみ保存可能であること
  # - 入力された販売価格によって、販売手数料や販売利益の表示が変わること
  # - 必要な情報を適切に入力すると、商品の出品ができること
  # - エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）
  # - 入力に問題がある状態で出品ボタンが押されたら、出品ページに戻りエラーメッセージが表示されること
  # 空の投稿を保存できないようにする
  # validates :title, :text, presence: true
  # ジャンルの選択が「--」の時は保存できないようにする
  # validates :genre_id, numericality: { other_than: 1 }