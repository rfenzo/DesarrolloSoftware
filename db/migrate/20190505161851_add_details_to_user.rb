class AddDetailsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :description, :string
    add_column :users, :rut, :string
    add_column :users, :address, :string
  end
end
