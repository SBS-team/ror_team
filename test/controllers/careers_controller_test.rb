require 'minitest_helper'

describe CareersController do

  ApplicationController.skip_before_filter :assign_gon_properties

  context 'GET #index' do

    it 'render #index' do
      get :index
      response.must render_template(:index)
    end

  end

end

