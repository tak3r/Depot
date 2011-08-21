class CreateSummaries < ActiveRecord::Migration
  def self.up
    create_table :summaries do |t|
      t.integer :timesheet_id
      t.string :cached_content

      t.timestamps
    end
  end

  def self.down
    drop_table :summaries
  end
end
