require 'minitest_helper'

describe JobsController do
  ApplicationController.skip_before_filter :assign_gon_properties

  describe 'GET #index' do

    it 'rendering' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_template partial: "_form"
      assert_response :success
    end

    it "resume must exists" do
      get :index
      refute_nil assigns(:resume)
      assert_nil assigns(:resume).id
    end

    describe "require jobs" do
      before do
        @jobs = []
        3.times do |i|
          @jobs[i] = FactoryGirl.create(:job)
        end
      end
      it "jobs must be" do
        get :index
        refute_nil assigns(:jobs)
        jobs = assigns(:jobs)
        jobs.length.must_equal 3
        jobs.each do |job|
          @jobs.must_include(job)
        end
      end

      it "jobs_for_select test" do
        get :index
        refute_nil assigns(:jobs_for_select)
        jobs = assigns(:jobs_for_select)
        jobs.length.must_equal 3
        jobs[0].must_respond_to :id
        jobs[0].must_respond_to :title
        jobs[0].wont_respond_to :description
      end
    end

  end

  describe "GET #show" do

    before do
      @job = FactoryGirl.create(:job)
    end

    it 'rendering' do
      get :show, id: @job
      assert_template :show
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_template partial: "_form"
      assert_response :success
    end

    it "resume must exists" do
      get :show, id: @job
      refute_nil assigns(:resume)
      assert_nil assigns(:resume).id
    end

    it "find job" do
      get :show, id: @job
      refute_nil assigns(:job)
      assigns(:job).must_equal @job
    end
  end
end