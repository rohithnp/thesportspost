class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :serialized_featured_article_ids, :string
    add_column :users, :serialized_favorite_sports, :string
  end
end
