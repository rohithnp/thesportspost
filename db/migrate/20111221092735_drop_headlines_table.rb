class DropHeadlinesTable < ActiveRecord::Migration
  def up
    drop_table :headlines
  end

  def down
  end
end
