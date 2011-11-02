class Category < ActiveRecord::Base
  has_many :articles

  def to_s
    full_name
  end
end
