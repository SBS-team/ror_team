require 'minitest_helper'

describe ViewTest do
  before do
    @manager = FactoryGirl.create(:admin_user, :role => 'manager', :email => 'manager@mail.com', :password => '12345678', :upload_file => FactoryGirl.create(:upload_file))
  end

  it 'Start to chat' do

    in_browser('manager') do
      visit admin_root_path
      fill_in 'admin_user[email]', :with => 'manager@mail.com'
      fill_in 'admin_user[password]', :with => '12345678'
      click_button('Login')
      click_link('Live Chats')
      click_link('Start chat')
    end

    in_browser('user') do
      visit root_path
      click_link('Live Chat')
      page.within_window page.driver.browser.window_handles.last do
        fill_in 'live_chat[guest_name]', :with => 'uzver'
        fill_in 'live_chat[guest_email]', :with => 'uzver@mail.com'
        fill_in 'message', :with => 'Hello! I am uzver...'
        click_button('Send Message')
      end
    end

    in_browser('manager') do
      page.within_window page.driver.browser.window_handles.last do
        assert page.has_content?('Hello! I am uzver...')
      end
    end

  end

end