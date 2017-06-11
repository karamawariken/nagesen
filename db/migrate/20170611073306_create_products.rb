class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :child_id
      t.text :title
      t.text :introduction
      t.text :introduction_voice_link
      t.text :image1_link
      t.text :image2_link
      t.text :image3_link
      t.text :state

      t.timestamps null: false
    end
  end
end
