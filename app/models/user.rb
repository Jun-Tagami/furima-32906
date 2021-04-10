class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ##############ここから下は復習用###############
  # ## 新規登録/ユーザー情報
  # - ニックネームが必須であること
  # validates :nickname, presence: true
  # - パスワードは、半角英数字混合での入力が必須であること
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は、半角英数字混合での入力が必須'

  # ## 新規登録/本人情報確認
  # - ユーザー本名は、名字と名前がそれぞれ必須であること
  # validates :last_name_kanji, presence: true
  # validates :first_name_kanji, presence: true

  # - ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  # validates :last_name_kanji, format: { with: /\A[ぁ-んァ-ヶ一-龥]+$+\z/ }
  # validates :first_name_kanji, format: { with: /\A[ぁ-んァ-ヶ一-龥]+\z/ }

  # - ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること
  # validates :last_name_kana, presence: true
  # validates :first_name_kana, presence: true

  # - ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること
  # validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  # validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }

  # - 生年月日が必須であること
  # validates :birthday, presence: true
 ##############ここから上は復習用###############


  with_options presence: true do
    validates :nickname
    validates :last_name_kanji
    validates :first_name_kanji
    validates :last_name_kana
    validates :first_name_kana
    validates :birthday
  end

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+$+\z/ } do
    validates :last_name_kanji
    validates :first_name_kanji
  end

  with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

end
