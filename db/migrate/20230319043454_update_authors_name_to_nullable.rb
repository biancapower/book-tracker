class UpdateAuthorsNameToNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :authors, :name, true
  end
end
