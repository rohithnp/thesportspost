class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_attached_file :image, :styles => {
    :thumb => 'x100',
    :big => '500x500>'
  }
end
