require 'minitest_helper'

describe HomeController do

  describe 'GET #index' do

    before do
      8.times do
        FactoryGirl.create(:technology)
        FactoryGirl.create(:project, :upload_files => [FactoryGirl.create(:upload_file)])
      end

      4.times do
        FactoryGirl.create(:job)
        FactoryGirl.create(:post, admin_id: FactoryGirl.create(:admin_user).id, :upload_file => FactoryGirl.create(:upload_file))
      end

    end

    it 'rendering' do
      get :index
      assert_template :index
      assert_template layout: 'layouts/application'
      assert_template partial: 'shared/_post_jobs'
      assert_response :success
    end

    it '@technologies assigns technology' do
      get :index
      refute_nil assigns(:technologies)
      assigns(:technologies).length.must_equal 8
      assigns(:technologies).must_include Technology.first
    end

    it '@projects assigns project' do
      get :index
      refute_nil assigns(:projects)
      assigns(:projects).length.must_equal 8
      assigns(:projects).must_include Project.first
    end

    it 'before action -> last_posts_and_jobs' do
      get :index
      refute_nil assigns(:last_jobs)
      assigns(:last_jobs).length.must_equal 4
      assigns(:last_jobs).must_include Job.first
      refute_nil assigns(:last_posts)
      assigns(:last_posts).length.must_equal 4
      assigns(:last_posts).must_include Post.first
    end

  end

end

