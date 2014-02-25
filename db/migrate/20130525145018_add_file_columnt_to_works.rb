class AddFileColumntToWorks < ActiveRecord::Migration
  def self.up
    add_attachment :works, :homework
  end

  def self.down
    remove_attachment :works, :homework
  end
end
