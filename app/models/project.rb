class Project < ActiveRecord::Base
  has_many :employees
  has_many :timesheets, :dependent => :destroy
end
