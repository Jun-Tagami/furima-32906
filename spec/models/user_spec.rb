require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe "ユーザー新規登録" do
    it "nicknameが空だと登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "メールアドレスが一意性であること"do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "メールアドレスは、@を含む必要があること"do
      @user.email = "111.111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが必須であること"do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードは、6文字以上での入力が必須であること"do
      @user.password = '1a1a1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードは、半角英数字混合での入力が必須であること"do
      @user.password = '1111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password パスワードは、半角英数字混合での入力が必須")
    end

    it "パスワードは、確認用を含めて2回入力すること"do
      @user.password = '111111a'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードとパスワード（確認用）、値の一致が必須であること"do
      @user.password = '111111a'
      @user.password_confirmation = '111111aa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

#  ## 新規登録/本人情報確認
    it "ユーザー本名は、名字が必須であること"do
      @user.last_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
    end

    it "ユーザー本名は、名前がそれぞれ必須であること"do
      @user.first_name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kanji can't be blank")
    end

    it "ユーザー本名（苗字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること"do
      @user.last_name_kanji = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kanji is invalid")
    end

    it "ユーザー本名(名前)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること"do
      @user.first_name_kanji = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kanji is invalid")
    end

    it "ユーザー本名（苗字）のフリガナは、名字が必須であること"do
      @user.last_name_kana  = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it "ユーザー本名(名前）のフリガナは、名前が必須であること"do
      @user.first_name_kana  = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

     it "ユーザー本名（苗字）のフリガナは、全角（カタカナ）での入力が必須であること"do
     @user.last_name_kana  = 'ﾊﾝｶｸｶﾀｶﾅ'
     @user.valid?
     expect(@user.errors.full_messages).to include("Last name kana is invalid")
     end

     it "ユーザー本名（名前）のフリガナは、全角（カタカナ）での入力が必須であること"do
     @user.first_name_kana  = 'ﾊﾝｶｸｶﾀｶﾅ'
     @user.valid?
     expect(@user.errors.full_messages).to include("first name kana is invalid")
     end

    it "生年月日が必須であること"do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end