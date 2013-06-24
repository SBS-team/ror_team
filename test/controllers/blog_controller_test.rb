require "minitest_helper"

class BlogControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
