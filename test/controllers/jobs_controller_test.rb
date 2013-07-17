require 'minitest_helper'

describe JobsController do

  describe "index" do
     before :each do
       5.times {FactoryGirl.create(:job)}
     end
    it 'test variable' do
      get 'index'
      assigns(:resume).wont_be_nil
      assigns(:jobs).wont_be_nil
      assigns(:all_jobs_for_select).wont_be_nil
      assigns(:jobs).count.must_equal 3
      assigns(:all_jobs_for_select).count.must_equal 5
    end
     it 'rendering' do
       get :index
       assert_template :index
       assert_response :success
       assert_template layout: "layouts/application"
       assert_template partial: "shared/_post_jobs"
       assert_template partial: "_form"
     end
     it 'jobs_for_select test' do
       get :index
       jobs = assigns(:all_jobs_for_select)
       jobs.length.must_equal 5
       jobs[0].must_respond_to :id
       jobs[0].must_respond_to :title
       jobs[0].wont_respond_to :description
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
    it 'fail_create test render show' do
      FactoryGirl.create(:job)
      post :create, :resume => FactoryGirl.attributes_for(:resume, :job_id => Job.first.id, :description => '')
      must_render_template :show
    end
  end
end