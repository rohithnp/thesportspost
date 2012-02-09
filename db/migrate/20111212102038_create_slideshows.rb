class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.integer :category_id
      t.text :article_ids

      t.timestamps
    end
  end
end
