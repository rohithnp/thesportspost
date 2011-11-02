class AddUserIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer, :null => false
  end
end
