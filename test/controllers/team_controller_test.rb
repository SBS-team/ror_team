require 'minitest_helper'

describe TeamController do

  describe 'GET #index' do

    it 'render #index' do
      get :index
      assert_template :index
      assert_template layout: 'layouts/application'
      assert_template partial: 'shared/_post_jobs'
      assert_response :ok

      admin_user = FactoryGirl.create(:admin_user, role: 'manager', upload_file: FactoryGirl.create(:upload_file))
      get :index, role: admin_user.role
      assigns(:team).must_include admin_user
      assert_response :ok
    end

  end

  describe 'GET #show' do

    it 'render #show' do
      5.times do
        @admin_user = FactoryGirl.create(:admin_user, upload_file: FactoryGirl.create(:upload_file))
      end

      get :show, id: @admin_user
      assert_template :show
      assert_template layout: 'layouts/application'
      assert_template partial: 'shared/_post_jobs'
      assert_response :ok
    end

  end

end