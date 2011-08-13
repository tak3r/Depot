class Timesheet < ActiveRecord::Base
  belongs_to :employee
  has_many :work_days, :dependent => :destroy
end
