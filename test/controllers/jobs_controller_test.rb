require 'minitest_helper'

describe JobsController do

  describe "index" do

     before :each do
       @admin = FactoryGirl.create(:admin_user)
       5.times do
         FactoryGirl.create(:job)
         FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
       end
     end

    it 'test variable' do
      get 'index'
      assigns(:resume).wont_be_nil
      assigns(:jobs).wont_be_nil
      assigns(:jobs).count.must_equal 3
    end
     it 'rendering' do
       get :index
       assert_template :index
       assert_response :success
       assert_template layout: "layouts/application"
       assert_template partial: "shared/_post_jobs"
       assert_template partial: "_form"
     end
  end
  describe 'show' do
    before :each do
      5.times {FactoryGirl.create(:job)}
      @show_job = FactoryGirl.create(:job)
    end
    it 'test variable' do
      get :show, :id => @show_job
      assigns(:job).must_equal @show_job
      assigns(:resume).wont_be_nil
    end
    it 'rendering' do
      get :show, id: @show_job
      assert_template :show
      assert_response :success
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_template partial: "_form"
    end
  end
  describe 'create' do
    it 'success create' do
      FactoryGirl.create(:job)
      post :create, :resume => FactoryGirl.attributes_for(:resume, :job_id => Job.first.id)
      assert_redirected_to jobs_path
    end
  end
end