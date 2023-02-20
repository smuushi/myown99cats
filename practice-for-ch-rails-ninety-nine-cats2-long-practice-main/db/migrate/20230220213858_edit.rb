class Edit < ActiveRecord::Migration[7.0]
  def change
    

    add_column :cats, :owner_id, :bigint, foreign_key: {to_table: :users}

    # add_ :cats, :owner, foreign_key: {to_table: :users}
  
  end

end
