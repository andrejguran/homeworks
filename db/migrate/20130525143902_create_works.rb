class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name
      t.references :task

      t.timestamps
    end
    add_index :works, :task_id
  end
end
