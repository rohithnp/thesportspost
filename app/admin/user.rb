ActiveAdmin.register User do
  menu :if => proc{ current_user.role?(:writer) || current_user.role?(:editor) }
  controller.authorize_resource
end
