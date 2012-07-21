class AddAttributesToBook < ActiveRecord::Migration
  def change
    add_column :books, :authors, :string, default: '', null: false
    add_column :books, :publisher, :string, default: '', null: false
    add_column :books, :published, :datetime
    add_column :books, :description, :text
    add_column :books, :google, :string, default: '', null: false
  end
end
