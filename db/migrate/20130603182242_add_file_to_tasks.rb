class AddFileToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :package, :string
    add_attachment :tasks, :task_file
  end

  def self.down
    remove_column :tasks, :package
    remove_attachment :tasks, :task_file
  end
end
