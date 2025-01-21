class CreateComicAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :comic_authors do |t|
      t.references :comic, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
