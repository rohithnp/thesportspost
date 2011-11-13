class AdminController < ApplicationController

  def index
    if current_user
      @categories = Category.all
      if params[:next]
        return redirect_to params[:next]
      end
      if current_user.role? :writer
        return redirect_to "/admin/articles"
      end
    else
      return redirect_to new_user_session_path :next => request.path
    end
  end
end
