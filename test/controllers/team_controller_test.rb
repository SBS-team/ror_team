require 'minitest_helper'

describe TeamController do
  ApplicationController.skip_before_filter :assign_gon_properties

  describe 'GET #index' do

    it 'render #index' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
    end

  end
end