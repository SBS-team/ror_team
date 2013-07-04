require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class ContactTest < IntegrationTest

  it 'Cannot be blank' do
    visit '/'
    click_link 'Contact'
    click_button 'Send Message'
    page.must have_content('Name cannot be blank')
    page.must have_content('Email cannot be blank')
  end

  it 'Email Cannot be blank' do
    visit '/'
    click_link 'Contact'
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    click_button 'Send Message'
    page.must have_content('Email cannot be blank.')
  end

  it 'Name Cannot be blank' do
    visit '/'
    click_link 'Contact'
    within('.email-phone') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    click_button 'Send Message'
    page.must have_content('Name cannot be blank.')
  end

  it 'Message was successfully sent' do
    visit '/'
    click_link 'Contact'
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    within('.email-phone') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    click_button 'Send Message'
    page.must have_content('Message was successfully sent')
  end

  it 'Fill up all form fields' do
    visit '/'
    click_link 'Contact'
    within('.name') do
      fill_in 'message_name', :with => 'Message Title 1'
    end
    within('.email-phone') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    within('.email-phone') do
      fill_in 'message_phone', :with => '123 45 67'
    end
    within('.text') do
      fill_in 'message_text', :with => 'Hi everyone im a newbie'
    end
    find('#message_service_type1').click
    find('#message_work_type_1').click
    click_button 'Send Message'
    page.must have_content('Message was successfully sent')
  end

end