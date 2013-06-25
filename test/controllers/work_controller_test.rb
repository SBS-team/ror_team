require "minitest_helper"

class WorkControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
