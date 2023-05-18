class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates_format_of :name, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, presence: true
  validates_format_of :sei, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, presence: true
  validates_format_of :kana_name, with: /\A[ァ-ヶー－ー]+\z/, presence: true
  validates_format_of :kana_sei, with: /\A[ァ-ヶー－ー]+\z/, presence: true
  validates :birth, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }
end
