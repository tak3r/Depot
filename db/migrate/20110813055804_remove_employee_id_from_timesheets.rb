class RemoveEmployeeIdFromTimesheets < ActiveRecord::Migration
  def self.up
    remove_column :timesheets, :employee_id
  end

  def self.down
    add_column :timesheets, :employee_id, :integer
  end
end
