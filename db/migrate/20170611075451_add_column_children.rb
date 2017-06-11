class AddColumnChildren < ActiveRecord::Migration
  def up
    add_column :children, :last_name, :text
    add_column :children, :nick_name, :text
  end
end
