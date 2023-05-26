class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :delivery_day
  belongs_to :prefecture

  with_options presence: true do
    validates :item_name
    validates :caption
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
  end
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :delivery_day_id
    validates :prefecture_id
  end
end
