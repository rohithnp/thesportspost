ActiveAdmin.register Article do
  controller.authorize_resource
  scope :all, :default => true do |articles|
    if current_user.role?(:writer)
      articles.where(:user_id => current_user.id)
    else
      articles
    end
  end
  index do
    column :title
    column :category
    column :user
    column :created_at
    default_actions
  end
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Article" do
      f.input :category
      f.input :title
      f.input :text
      f.input :image, :as => :file
    end
    f.buttons
  end
end
