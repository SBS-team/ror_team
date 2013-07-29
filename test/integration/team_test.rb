require 'minitest_helper'

describe ViewTest do
  before do
      FactoryGirl.create(:admin_user, :upload_file => FactoryGirl.create(:upload_file))
      FactoryGirl.create(:admin_user, :upload_file => FactoryGirl.create(:upload_file))
      FactoryGirl.create(:admin_user, :first_name => 'Mega_ADMIN', :upload_file => FactoryGirl.create(:upload_file))
  end


  it "check" do
    visit root_path
    click_link 'Team'
    sleep(2)
    click_link 'Mega_ADMIN'
    sleep(1)
    page.find_by_id('pic2').click
    sleep(1)
    page.find_by_id('pic3').click
    sleep(1)
  end
end