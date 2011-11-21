class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if params[:favorites] and current_user.email == params[:user][:email]
      current_user.favorite_sports = (Set.new(Category.all.map {|c| c.name }) & params[:favorites].keys).to_a
      current_user.save
    end
  end

  def update
    super
  end
end
