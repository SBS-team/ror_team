require 'minitest_helper'

describe HomeController do

  ApplicationController.skip_before_filter :assign_gon_properties

  before :each do
    3.times do
      FactoryGirl.create(:post)
    end
  end

  context 'GET #index' do

    it 'render #index' do
      get :index
      response.must render_template(:index)
    end

  end

end