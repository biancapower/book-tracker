class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :open_library_key, null: false
      t.string :name, null: false
      t.string :birth_date
      t.string :alternate_names, array: true, default: []

      t.timestamps
    end

    add_index :authors, :open_library_key, unique: true
  end
end
