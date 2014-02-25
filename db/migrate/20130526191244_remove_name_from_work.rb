class RemoveNameFromWork < ActiveRecord::Migration
  def self.up
    remove_column :works, :name
  end

  def self.down
    add_column :works, :name
  end
end
