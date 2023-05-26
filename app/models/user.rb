class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :sei, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :kana_name, format: { with: /\A[ァ-ヶー]+\z/ }
    validates :kana_sei, format: { with: /\A[ァ-ヶー]+\z/ }
    validates :birth
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX }
  end

  has_many :items
  has_many :orders
end
