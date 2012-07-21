class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn, default: '', null: false
      t.string :title, default: '', null: false
      t.string :image, default: '', null: false
      t.string :place, default: '', null: false

      t.timestamps
    end
  end
end
