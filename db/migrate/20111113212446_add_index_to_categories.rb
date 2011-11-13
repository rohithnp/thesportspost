class AddIndexToCategories < ActiveRecord::Migration
  def change
    add_index :categories, [:name, :full_name], :unique
  end
end
