class Employee < ActiveRecord::Base
  validates :name, :salary, :job, :presence => true
  validates :salary, :numericality => {:greater_than_or_equal_to => 0.01}
  has_many :timesheets, :dependent => :destroy
  belongs_to :project
end
