<<<<<<< HEAD
ActiveAdmin.register Customer do
=======
# app/admin/customers.rb
ActiveAdmin.register Customer do
  permit_params :name, :address, :email
>>>>>>> origin/master

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
