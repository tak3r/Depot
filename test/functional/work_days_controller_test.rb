require 'test_helper'

class WorkDaysControllerTest < ActionController::TestCase
  setup do
    @work_day = work_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_day" do
    assert_difference('WorkDay.count') do
      post :create, :work_day => @work_day.attributes
    end

    assert_redirected_to work_day_path(assigns(:work_day))
  end

  test "should show work_day" do
    get :show, :id => @work_day.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @work_day.to_param
    assert_response :success
  end

  test "should update work_day" do
    put :update, :id => @work_day.to_param, :work_day => @work_day.attributes
    assert_redirected_to work_day_path(assigns(:work_day))
  end

  test "should destroy work_day" do
    assert_difference('WorkDay.count', -1) do
      delete :destroy, :id => @work_day.to_param
    end

    assert_redirected_to work_days_path
  end
end
