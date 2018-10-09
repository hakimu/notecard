class AddPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password, :digest
  end
end
