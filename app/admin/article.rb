ActiveAdmin.register Article do
  index do
    column :title
    column :user
    column :created_at
    default_actions
  end
end
