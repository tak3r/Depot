class CreateWorkDays < ActiveRecord::Migration
  def self.up
    create_table :work_days do |t|
      t.date :day
      t.text :comment
      t.integer :timesheet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :work_days
  end
end
