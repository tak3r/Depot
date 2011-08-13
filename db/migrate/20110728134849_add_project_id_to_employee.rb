class AddProjectIdToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :project_id, :integer
  end

  def self.down
    remove_column :employees, :project_id
  end
end
