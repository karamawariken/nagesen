class RenameNameColumnToChildren < ActiveRecord::Migration
  def change
    rename_column :children, :name, :first_name
  end
end
