class CreateFollowRelationships < ActiveRecord::Migration
  def change
    create_table :follow_relationships do |t|
      t.integer :user_id
      t.integer :kid_id

      t.timestamps null: false
    end
  end
end
