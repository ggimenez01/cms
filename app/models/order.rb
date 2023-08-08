class Order < ApplicationRecord
<<<<<<< HEAD
  belongs_to :customer, inverse_of: :orders, autosave: true
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :user, optional: true

  accepts_nested_attributes_for :customer

  validates :total, :status, :gst, :pst, :hst, :subtotal, presence: true
  validates :total, :gst, :pst, :hst, :subtotal, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at customer_id gst hst id pst status subtotal total updated_at]
=======
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
>>>>>>> origin/master
  end
end
