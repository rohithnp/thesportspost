class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_attached_file :image, :styles => {
    :thumb => 'x100',
    :big => '500x500>'
  }

  IMAGE_POSITIONS = [
    ['top-left', 0],
    ['top-right', 1],
    ['mid-left', 2],
    ['mid-right', 3],
    ['bottom-left', 4],
    ['bottom-right', 5]
  ]
end
