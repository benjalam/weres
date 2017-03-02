ActiveAdmin.register Candidate do
  permit_params :name, :user_id, :position, :job_offer_id, :email

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
        f.input :name
        f.input :user, as: :select, collection: User.all.map {|user| "#{user.first_name} #{user.company.name}" }
        f.input :position
        f.input :job_offer
        f.input :email
    end
    actions
  end
end
