require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  describe '商品作成' do
    context '必要な情報を適切に入力すると、商品の出品ができること' do
      it 'すべての情報が入力されていれば出品できること' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it '商品名が必須であること' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end

      it 'category_idを0と選択すると登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'status_idを0と選択すると登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'delivery_fee_idを0と選択すると登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'area_idを0と選択すると登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'ship_idを0と選択すると登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it '商品の状態についての情報が必須であること' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Status is not a number')
      end

      it '配送料の負担についての情報が必須であること' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee is not a number')
      end

      it '発送元の地域についての情報が必須であること' do
        @item.area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Area is not a number')
      end

      it '発送までの日数についての情報が必須であること' do
        @item.ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship is not a number')
      end

      it '価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格の範囲が、¥300以上であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end

      it '価格の範囲が、¥9999999以下であること' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
      end

      it '販売価格は英数混合では登録できないこと' do
        @item.price = '1a1a1a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
      end

      it '販売価格は半角英語のみでは登録できないこと' do
        @item.price = 'aaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で入力してください')
      end

      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end

# ########以下は復習用です
# - 入力された販売価格によって、販売手数料や販売利益の表示が変わること（JSで確認）→テストコードには書かない実装が確認できれば良い
# - エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）
#    ↑ テストの実装項目ではない   1項目だけ抜けている状態の方が良い→うっかりミスのような状態になる（精度が高い）
# アプリ上のバリデーションがかかっている
# errorメッセージを表示させる
# テストコードとは別個のもの
