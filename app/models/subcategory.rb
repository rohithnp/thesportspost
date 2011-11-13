class Subcategory < ActiveRecord::Base
  has_many :articles
  belongs_to :category
  
  def to_s
    name
  end
end
