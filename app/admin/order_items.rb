# app/admin/order_items.rb
<<<<<<< HEAD

ActiveAdmin.register OrderItem do
  # Permit the attributes you want to be editable in Active Admin
  permit_params :order_id, :product_id, :quantity, :price

  # Define the columns to be displayed in the index page
=======
ActiveAdmin.register OrderItem do
  permit_params :order_id, :product_id, :quantity, :price

>>>>>>> origin/master
  index do
    selectable_column
    id_column
    column :order
    column :product
    column :quantity
    column :price
    actions
  end

<<<<<<< HEAD
  # Add any filters you want to use on the index page
=======
>>>>>>> origin/master
  filter :order
  filter :product
  filter :quantity
  filter :price

<<<<<<< HEAD
  # Define the form for the edit and new pages
  form do |f|
    f.inputs 'Order Item Details' do
=======
  form do |f|
    f.inputs do
>>>>>>> origin/master
      f.input :order
      f.input :product
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
