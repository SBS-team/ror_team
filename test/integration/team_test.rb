require 'minitest_helper'

describe ViewTest do
  before do
      FactoryGirl.create(:admin_user, :upload_files =>[FactoryGirl.create(:upload_file)])
      FactoryGirl.create(:admin_user, :upload_files =>[FactoryGirl.create(:upload_file)])
      FactoryGirl.create(:admin_user, :upload_files =>[FactoryGirl.create(:upload_file)])
  end


  it "check" do
    visit '/'
    click_link 'Team'
    sleep(2)

    click_link 'first_name3'
    sleep(1)
    page.find_by_id('pic1').click
    sleep(1)
    page.find_by_id('pic2').click
    sleep(1)
    page.find_by_id('pic3').click
    sleep(1)
  end
end