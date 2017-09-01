class AddAvatarToKids < ActiveRecord::Migration
  def change
    add_column :kids, :avatar, :text
  end
end
