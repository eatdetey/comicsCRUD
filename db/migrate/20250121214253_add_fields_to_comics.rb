class AddFieldsToComics < ActiveRecord::Migration[8.0]
  def change
    add_column :comics, :description, :text
    add_column :comics, :genre, :string
    add_column :comics, :published_on, :date
    add_reference :comics, :publisher, null: false, foreign_key: true
  end
end
