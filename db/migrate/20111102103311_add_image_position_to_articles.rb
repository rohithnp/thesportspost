class AddImagePositionToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image_position, :integer
  end
end
