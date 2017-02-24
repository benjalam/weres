ActiveAdmin.register User do

  permit_params :email, :first_name, :last_name, :company_admin, :admin, :company_id

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
   form do |f|
    inputs do
        f.input :first_name
        f.input :last_name
        f.input :company, as: :select, collection: Company.all.map {|c| "#{c.name}" }
        f.input :email
        f.input :password

    end
    actions
  end

end
