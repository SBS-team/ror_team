require 'minitest_helper'

describe TimeOnlinesController do

  it 'add 10 min to time_online current_admin_user' do
    admin = FactoryGirl.create(:admin_user, upload_file: FactoryGirl.create(:upload_file))
    sign_in admin
    admin.time_onlines.must_be_empty
    admin.last_activity.must_be_nil

    post :set_time
    admin.time_onlines.first.time.must_equal 10
    admin.time_onlines.count.must_equal 1
  end

  it 'add 10 min with last_activity' do
    admin = FactoryGirl.create(:admin_user, last_activity: 10.minutes.ago, upload_file: FactoryGirl.create(:upload_file))
    sign_in admin
    admin.time_onlines.must_be_empty

    post :set_time
    admin.time_onlines.first.time.must_equal 10
    admin.time_onlines.count.must_equal 1
  end

end