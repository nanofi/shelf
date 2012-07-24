class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :book, null: false
      t.text :body, null: false

      t.timestamps
    end
    add_index :comments, :book_id
  end
end
