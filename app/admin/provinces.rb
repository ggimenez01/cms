<<<<<<< HEAD
# app/admin/provinces.rb
ActiveAdmin.register Province do
  permit_params :name
  filter :name
  filter :created_at
=======
# app/admin/province.rb
ActiveAdmin.register Province do
  permit_params :name
>>>>>>> origin/master
end
