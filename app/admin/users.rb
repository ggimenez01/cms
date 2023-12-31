ActiveAdmin.register User do
  permit_params :name, :address, :province_id, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :email
    column "Province" do |user|
      user.province.name
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :province
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
