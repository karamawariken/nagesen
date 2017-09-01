class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :integer
  end
end
