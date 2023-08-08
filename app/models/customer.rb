class Customer < ApplicationRecord
  belongs_to :province
<<<<<<< HEAD
  has_many :orders, inverse_of: :customer
  validates :name, :address, :email, :province_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[address created_at email id name province_id updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[orders province]
=======
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "province_id", "updated_at", "address"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end

  ransacker :address_cont do
    Arel::Nodes::NamedFunction.new('LOWER', [Arel::Nodes::NamedFunction.new('COALESCE', [Arel.sql("address"), "''"])])
      .matches("%#{address.mb_chars.downcase}%")
>>>>>>> origin/master
  end
end
