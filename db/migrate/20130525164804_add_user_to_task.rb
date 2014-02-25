class AddUserToTask < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.references :user
    end
  end

  def self.down
    change_table :tasks do |t|
      t.remove_references :user
    end
  end
end
