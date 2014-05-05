class AddDeadlineToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :deadline, :datetime
  end

  def self.down
    remove_column :tasks, :deadline
  end
end
