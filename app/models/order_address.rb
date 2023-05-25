class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address, :building_name, :tel, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :tel, format: {with: /\A\d{10,11}\z/}
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, tel: tel, order_id: order.id)
  end
end