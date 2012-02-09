class AddIsDraftColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_draft, :boolean
  end
end
