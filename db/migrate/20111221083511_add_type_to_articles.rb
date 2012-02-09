class AddTypeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_type, :integer
  end
end
