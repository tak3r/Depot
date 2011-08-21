class Timesheet < ActiveRecord::Base
  validates :project_id, :start_date, :presence => true
  belongs_to :project
  has_many :work_days, :dependent => :destroy
  has_one :summaries, :dependent => :destroy
end
