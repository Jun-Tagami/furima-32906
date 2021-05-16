require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
    sleep 0.5 # 復習用→これを使うことでサーバーの負担が減る  データベースに保存する間を与えてあげる。errorが出てしまう。sever criant errorが出る。
  end

  describe '購入機能' do
    context '購入ができるとき' do
      it 'すべての情報が入力されていれば登録できること' do
        expect(@order_address).to be_valid
      end

      it '配送先の情報として、建物名が空欄でも登録できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '新規登録できないとき' do
      it '配送先の情報として、郵便番号が必須であること' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '配送先の情報として、都道府県が必須であること' do
        @order_address.area_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Area must be other than 0')
      end

      it '配送先の情報として、市区町村が必須であること' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '配送先の情報として、番地が必須であること' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end

      it '配送先の情報として、電話番号が必須であること' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '郵便番号にはハイフンが必要であること（123-4567となる）' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end

      it '電話番号には11桁以内であること（09012345678となる）' do
        @order_address.phone_number = '0901234567890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Maximum is 11 characters')
      end

      it '電話番号が英数混合では登録できないこと' do
        @order_address.phone_number = 'a901234567890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end


      it 'tokenが空では登録できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'item_idが空では登録できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_id が空では登録できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end

########################
# 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
# 配送先の情報として、建物名が空欄でも登録できること→OK
# 郵便番号にはハイフンが必要であること（123-4567となる）
# 電話番号にはハイフンは不要で、11桁以内であること（09012345678となる）
# 購入が完了したら、トップページまたは購入完了ページに遷移すること
# エラーハンドリングができていること（適切では無い値が入力された場合、情報は保存されず、エラーメッセージを出力させること）
# 入力に問題がある状態で購入ボタンが押されたら、購入ページに戻りエラーメッセージが表示されること
