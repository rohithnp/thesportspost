class AddOtherArticlesByWriterToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :serialized_same_writer_article_ids, :string
  end

  def self.down
    remove_column :articles, :serialized_same_writer_article_ids
  end
end
