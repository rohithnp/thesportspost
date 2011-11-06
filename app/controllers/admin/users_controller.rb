class Admin::UsersController < ApplicationController
  before_filter :authorize_user_admin

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    p params[:user][:roles_mask].to_i
    @user.roles_mask = params[:user][:roles_mask].to_i
    if @user.save
      redirect_to :action => 'index'
    end
  end

  def authorize_user_admin
    authorize! :manage, User
  end
end
