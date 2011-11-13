class AddSubcategoryIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :subcategory_id, :integer
  end
end
