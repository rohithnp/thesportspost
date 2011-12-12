class Category < ActiveRecord::Base
  has_many :articles
  has_many :subcategories

  validates_presence_of :name, :full_name
  validates_uniqueness_of [:name, :full_name]

  def to_s
    full_name
  end
end
