require "faker"
require "csv"

# Read data from the CSV file
csv_data = CSV.read(Rails.root.join("db/medicine1.csv"), headers: true)

# Iterate over each row in the CSV file and create products
csv_data.each do |row|
  supplier_name = row["Supplier Name"]
  mat_id = row["Mat ID"]
  name = row["Name"]
  uom = row["UOM"]
  price = row["Price"].to_f
  description = Faker::Lorem.paragraph
  category_name = row["Categories"]

  # Find or create the supplier
  supplier = Supplier.find_or_create_by(name: supplier_name)

  # Find or create the category
  category = Category.find_or_create_by(name: category_name)

  # Create the product with the assigned category and supplier
  product = Product.create(
    name:,
    description:,
    price:,
    category:,
    supplier:,
    mat_id:,
    uom:
  )

  Rails.logger.debug "Created product: #{product.name}"
  Rails.logger.debug "mat_id: #{product.mat_id}"
  Rails.logger.debug "uom: #{product.uom}"
end

if Rails.env.development?
  AdminUser.create!(email: "admin@gdigital.com", password: "password",
                    password_confirmation: "password")
end
