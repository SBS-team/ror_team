require 'minitest_helper'

describe ApplicationController do

  before do
    @admin = FactoryGirl.create(:admin_user, :role => 'admin')
    10.times do
      FactoryGirl.create(:post, :admin_user_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
      FactoryGirl.create(:job)
    end
    @controller = ApplicationController.new
  end

  it 'last_posts_and_jobs' do
    @controller.send 'last_posts_and_jobs'
    @controller.instance_variable_get(:@last_posts).count.must_equal 4
    @controller.instance_variable_get(:@last_jobs).count.must_equal 4
  end

end