class Edits < ActiveRecord::Migration[7.0]
  def change

    add_foreign_key :cats, :users, column: :owner_id

  end
end
