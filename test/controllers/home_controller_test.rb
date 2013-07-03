require 'minitest_helper'

describe HomeController do

  ApplicationController.skip_before_filter :assign_gon_properties

  describe 'GET #index' do

    it 'rendering' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_response :success
    end

    it 'show some technologies' do
      tech_cat = FactoryGirl.create(:technology_category)
      techs = []
      10.times do |i|
        techs[i]= FactoryGirl.create(:technology, technology_category_id: tech_cat.id)
      end

      get :index
      refute_nil assigns(:tech)
      some_techs = assigns(:tech)
      some_techs.length.must_equal 8

      some_techs.length.times do |i|
        techs.must_include(some_techs[i])
      end
    end

    it 'show some projects' do
      projects = []
      10.times do |i|
        projects[i]= FactoryGirl.build(:project)
        projects[i].upload_files << FactoryGirl.create(:upload_file)
        projects[i].save
      end
      get :index
      refute_nil assigns(:some_projects)
      some_projects = assigns(:some_projects)
      some_projects.length.must_equal 8

      some_projects.length.times do |i|
        projects.must_include(some_projects[i])
      end
    end

  end

end