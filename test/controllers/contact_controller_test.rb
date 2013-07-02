require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ContactController do

  it 'should get index' do
    get :index
    assert_response :success
  end

end