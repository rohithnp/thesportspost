class AddPageviewsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :pageviews, :integer
    add_column :articles, :current_month_pageviews, :integer
  end
end
