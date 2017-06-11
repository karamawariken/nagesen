class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.string :sex, limit: 1
      t.integer :age, limit: 3
      t.date :birthday

      t.timestamps null: false
    end
  end
end
