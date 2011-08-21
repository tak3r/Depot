class AddEmployeeIdToWorkDays < ActiveRecord::Migration
  def self.up
    add_column :work_days, :employee_id, :integer
  end

  def self.down
    remove_column :work_days, :employee_id
  end
end
