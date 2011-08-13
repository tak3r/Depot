require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  test "employee attributes must be set properly" do
    employee = Employee.new
    assert employee.invalid?
    assert employee.errors[:name].any?
    assert employee.errors[:salary].any?
    assert employee.errors[:job].any?
  end
  
  test "employee successfully created with valid attributes" do
    employee = Employee.new(:name => "John Doe",
                            :salary => 50.0,
                            :job => "Software developer")
    assert employee.valid?
  end
end
