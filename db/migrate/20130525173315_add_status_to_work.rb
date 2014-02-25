class AddStatusToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :status, :string, :default => 'pending'
  end

  def self.down
    remove_column :works, :status
  end
end
