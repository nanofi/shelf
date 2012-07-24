class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :memo, null: false, default: ''
      t.references :book, null: false
      t.references :place

      t.timestamps
    end
    add_index :entities, :book_id
    add_index :entities, :place_id
  end
end
