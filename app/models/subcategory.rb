class Subcategory < ActiveRecord::Base
  has_many :articles
  belongs_to :category
  before_save :generate_slug
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_s
    name
  end
 
  protected
  def generate_slug
    self.slug = name.downcase.gsub(/[^a-z ]/,'').gsub(/ +/,'-')
  end
end
