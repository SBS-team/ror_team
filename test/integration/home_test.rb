require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class HomeTest < IntegrationTest
  it "home with ajax" do
    visit '/'
    click_link 'Company'
    sleep(5)
    click_link 'Work'
    sleep(5)
    click_link 'Team'
    sleep(5)
    click_link 'Careers'
    sleep(5)
    click_link 'Contact'
    sleep(5)
    click_link 'Blog'
    sleep(5)
  end
end