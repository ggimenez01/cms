class Customer < ApplicationRecord
  belongs_to :province
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
  end
end
