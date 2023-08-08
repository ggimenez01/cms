class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

<<<<<<< HEAD
  validates :product_id, :quantity, :price, presence: true
  validates :quantity, numericality: { only_integer: true }
  validates :price, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id order_id price product_id quantity updated_at]
=======
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
>>>>>>> origin/master
  end
end
