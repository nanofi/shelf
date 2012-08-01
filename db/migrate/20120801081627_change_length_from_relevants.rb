class ChangeLengthFromRelevants < ActiveRecord::Migration
  def up
    change_column :relevants, :url, :text, null: false, length: 2048
  end
  def down
    change_column :relevants, :url, :string, null: false
  end
end
