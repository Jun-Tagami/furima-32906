class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ## 新規登録/ユーザー情報
  # - ニックネームが必須であること
  validates :nickname, presence: true
  # - パスワードは、半角英数字混合での入力が必須であること
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'パスワードは、半角英数字混合での入力が必須' 

  # ## 新規登録/本人情報確認
  # - ユーザー本名は、名字と名前がそれぞれ必須であること
  validates :last_name_kanji, presence: true
  validates :first_name_kanji, presence: true

  # - ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること
  validates :last_name_kanji, format: { with: /\A[ぁ-んァ-ヶ一-龥]+\z/ }
  validates :first_name_kanji, format: { with: /\A[ぁ-んァ-ヶ一-龥]+\z/ }

  # - ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  # - ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }

  # - 生年月日が必須であること
  validates :birthday, presence: true

end