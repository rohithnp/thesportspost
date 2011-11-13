class CreatePageSections < ActiveRecord::Migration
  def change
    create_table :page_sections do |t|
      t.string :name
      t.integer :type
      t.integer :position
      t.string :serialized_article_ids

      t.timestamps
    end
  end
end
