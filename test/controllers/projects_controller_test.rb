require 'minitest_helper'

describe ProjectsController do
  ApplicationController.skip_before_filter :assign_gon_properties
  include CarrierWave::Test::Matchers
  before do
    @project = FactoryGirl.create(:project, :upload_files => [FactoryGirl.create(:upload_file)])
  end

  describe 'GET #index' do

    it 'render #index' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_response :success
      refute_nil assigns(:projects)
      assert_includes(assigns(:projects), @project)
    end

  end

  describe 'GET #show' do

    it 'render #index' do
      get :show, id: @project.id
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
    end

    it "exists @projects" do
      get :show, id: @project
      refute_nil assigns(:projects)
      assert_includes(assigns(:projects), @project)
    end

  end
end
