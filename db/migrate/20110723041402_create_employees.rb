class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :name
      t.date :dob
      t.decimal :salary, :precision => 8, :scale => 2
      t.string :job
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
