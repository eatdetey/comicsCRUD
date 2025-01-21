class CreateComics < ActiveRecord::Migration[8.0]
  def change
    create_table :comics do |t|
      t.string :title

      t.timestamps
    end
  end
end
