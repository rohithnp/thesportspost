class DropSlideshowTable < ActiveRecord::Migration
  def up
    drop_table :slideshows
  end
end
