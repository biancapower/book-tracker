class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :open_library_key, null: false
      t.string :title, null: false
      t.integer :number_of_pages
      t.text :first_sentence
      t.text :description
      t.string :cover_images, array: true, default: []

      t.timestamps
    end

    add_index :books, :open_library_key, unique: true
  end
end
