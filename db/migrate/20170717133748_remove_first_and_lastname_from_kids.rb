class RemoveFirstAndLastnameFromKids < ActiveRecord::Migration
  def change
    remove_column :kids, :first_name, :string
    remove_column :kids, :last_name, :string
  end
end
