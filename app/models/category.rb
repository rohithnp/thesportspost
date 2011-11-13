class Category < ActiveRecord::Base
  has_many :articles
  has_many :subcategories

  def to_s
    full_name
  end
end
