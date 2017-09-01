class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :nick_name
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :sex
      t.date :birthday
      t.text :introduction
      t.timestamps null: false
    end
  end
end
