class CreateRelevants < ActiveRecord::Migration
  def change
    create_table :relevants do |t|
      t.string :what, null: false, default: 'link'
      t.string :url, null: false
      t.references :book

      t.timestamps
    end
    add_index :relevants, :book_id
  end
end
