require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class ContactTest < IntegrationTest
  it 'Visit Contact' do
    visit '/'
    click_link 'Contact'
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    click_button 'Send Message'
    page.must have_content('Email cannot be blank.')
  end

end