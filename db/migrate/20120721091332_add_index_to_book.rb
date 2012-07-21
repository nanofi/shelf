class AddIndexToBook < ActiveRecord::Migration
  def change
    add_index :books, :title
    add_index :books, :updated_at
  end
end
