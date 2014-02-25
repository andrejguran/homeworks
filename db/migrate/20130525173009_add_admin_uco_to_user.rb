class AddAdminUcoToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :uco, :integer
  end

  def self.down
    remove_column :users, :admin
    remove_column :users, :uco
  end
end
