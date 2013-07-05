require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class TeamTest < IntegrationTest

  before do
      FactoryGirl.create(:admin_user)
      FactoryGirl.create(:admin_user, :upload_files =>[FactoryGirl.create(:upload_file)])
      FactoryGirl.create(:admin_user, :upload_files =>[FactoryGirl.create(:upload_file)])
  end


  it "check" do
    visit '/'
    click_link 'Team'
    sleep(2)
    click_link 'first_name3'
    sleep(2)
    click_link '1'
    sleep(1)
    click_link '2'
    sleep(1)
    click_link '3'
    sleep(1)

  end
end