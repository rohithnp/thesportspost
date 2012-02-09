class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
      t.integer :category_id
      t.text :article_ids

      t.timestamps
    end
  end
end
