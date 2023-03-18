class CreateAuthorBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :author_books do |t|
      t.references :author, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    # Add a unique index to prevent duplicate author-book relationships
    add_index :author_books, [:author_id, :book_id], unique: true
  end
end
