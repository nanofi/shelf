class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.integer :entities_count, null: false, default: 0
    end
    add_index :places, :name, unique: true
  end
end
