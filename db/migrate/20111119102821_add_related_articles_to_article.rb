class AddRelatedArticlesToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :serialized_related_article_ids, :string
  end
end
