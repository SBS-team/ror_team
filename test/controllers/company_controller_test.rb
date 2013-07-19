require 'minitest_helper'

describe CompanyController do

  before :each do
    @services = Array.new
    @tech_cats = Array.new
    3.times do |i|
      @services[i] = FactoryGirl.create(:service, :upload_files => [FactoryGirl.create(:upload_file)])
      @tech_cats[i] = FactoryGirl.create(:technology_category)
    end
  end

  context 'GET #index' do

    it 'render #index' do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
      assert_template partial: "shared/_post_jobs"
      assert_response :success
    end

    it 'assigns service to @services' do
      get :index
      refute_nil assigns(:services)
      refute_empty assigns(:services)
      services = assigns(:services)
      services.length.must_equal 3
      services.length.times do |i|
        services[i].must_be_kind_of Service
        @services.must_include(services[i])
      end
    end

    it 'assigns technology_category to @technology_categories' do
      get :index
      refute_nil assigns(:technology_categories)
      refute_empty assigns(:technology_categories)
      tech_cats = assigns(:technology_categories)
      tech_cats.length.must_equal 3
      tech_cats.length.times do |i|
        tech_cats[i].must_be_kind_of TechnologyCategory
        @tech_cats.must_include(tech_cats[i])
      end
    end

  end

end

