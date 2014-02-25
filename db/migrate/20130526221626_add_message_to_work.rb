class AddMessageToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :message, :text
  end

  def self.down
    remove_column :works, :message
  end
end
