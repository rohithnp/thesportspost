ActiveAdmin.register User do
  controller.authorize_resource
  menu :if => proc{ current_user.role?(:admin) }
end
