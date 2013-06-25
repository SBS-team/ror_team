require "minitest_helper"

class CareersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
