class ModifyUser < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :trainer
  	add_column :users, :role, :string
  end
end
