class AddStartDateToTimesheets < ActiveRecord::Migration
  def self.up
    add_column :timesheets, :start_date, :date
  end

  def self.down
    remove_column :timesheets, :start_date
  end
end
