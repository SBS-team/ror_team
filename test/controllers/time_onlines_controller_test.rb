require 'minitest_helper'

describe TimeOnlinesController do

  before do
    @admin = FactoryGirl.create(:admin_user, :upload_file => FactoryGirl.create(:upload_file))
    @user = FactoryGirl.create(:admin_user, :upload_file => FactoryGirl.create(:upload_file))
  end

  it 'add 10 min to time_online current_admin_user' do
    sign_in @admin
    @admin.time_onlines.must_be_empty
    post :set_time
    @admin.time_onlines.first.time.must_equal 10
    post :set_time
    @admin.time_onlines.first.time.must_equal 20
    @user.time_onlines.must_be_empty
    @admin.time_onlines.count.must_equal 1
  end

end