class AddCreatedUserToKids < ActiveRecord::Migration
  def change
    add_column :kids, :created_user_id, :integer
  end
end
