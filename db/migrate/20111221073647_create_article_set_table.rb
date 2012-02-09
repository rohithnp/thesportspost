class CreateArticleSetTable < ActiveRecord::Migration
  def change
    create_table :article_sets do |t|
      t.string :slug
      t.string :full_name
      t.integer :category_id
      t.integer :subcategory_id
      t.integer :max_articles
      t.text :article_ids
      t.timestamps
    end
  end
end
