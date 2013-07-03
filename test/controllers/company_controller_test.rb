require 'minitest_helper'

describe CompanyController do

  ApplicationController.skip_before_filter :assign_gon_properties

  before :each do
    3.times do
      FactoryGirl.create(:service)
      FactoryGirl.create(:technology_category)
      FactoryGirl.create(:post)
      FactoryGirl.create(:job)
    end
  end

  context 'GET #index' do

    it 'render #index' do
      get :index
      response.must render_template(:index)
    end

    it 'assigns service to @services' do
      get :index
      assigns(:services).count.must_be :==, 3
    end

    it 'assigns technology_category to @technology_categories' do
      get :index
      assigns(:technology_categories).count.must_be :==, 3
    end

    it 'before_filter :new_posts_and_jobs' do
      get :index
      assigns(:new_posts).count.must_be :==, 3
      assigns(:new_jobs).count.must_be :==, 3
    end

  end

end

