class AddProjectIdToTimesheets < ActiveRecord::Migration
  def self.up
    add_column :timesheets, :project_id, :integer
  end

  def self.down
    remove_column :timesheets, :project_id
  end
end
