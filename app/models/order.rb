class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  has_many :order_items
  accepts_nested_attributes_for :order_items
  attr_accessor :hst, :gst, :pst
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "product_id", "quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "order_items.product"]
  end
end
