require 'minitest_helper'

describe WorkController do
  ApplicationController.skip_before_filter :assign_gon_properties

  before do
    @project1 = FactoryGirl.build(:project)
    @project1.upload_files << FactoryGirl.create(:upload_file)
    @project1.save

    @project2 = FactoryGirl.build(:project)
    @project2.upload_files << FactoryGirl.create(:upload_file)
    @project2.save

=begin
    @posts = []
    5.times do
      post = FactoryGirl.build(:post)
      post.upload_files << FactoryGirl.create(:upload_file)
      post.save
      @posts << post
    end
=end
  end

  describe 'GET #index' do

    it 'render #index' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_response :success

      refute_nil assigns(:projects)
      assert_includes(assigns(:projects), @project1)
      assert_includes(assigns(:projects), @project2)

=begin
  #проверка вывода последних 4 постов в "shared/_post_jobs" пока не знаю где разместить
      refute_nil assigns(:posts)
      assert_includes(assigns(:posts), @posts[4])
      refute_includes(assigns(:posts), @posts[0])
=end

    end

  end

  describe 'GET #show' do

    it 'render #index' do
      get :show, id: @project1
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
    end

    it "exists @projects" do
      get :show, id: @project1
      refute_nil assigns(:projects)
      assert_includes(assigns(:projects), @project1)
      refute_includes(assigns(:projects), @project2)
    end

  end
end

