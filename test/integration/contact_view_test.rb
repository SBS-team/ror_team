require 'minitest_helper'

describe ViewTest do

  before do
    FactoryGirl.create(:service,:name => 'RoRoRoRoR' , :upload_file => FactoryGirl.create(:upload_file))
    visit contact_index_path
  end

  it 'Cannot be blank' do
    find('.submit-form input').click
    assert page.has_content?('This field is required.')
  end

  it 'Email Cannot be blank' do
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    find('.submit-form input').click
    assert page.has_content?('This field is required.')
  end

  it 'Name Cannot be blank' do
    within('.email') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    find('.submit-form input').click
    assert page.has_content?("This field is required.")
  end

  it 'Message was successfully sent' do
    within('.name') do
      fill_in 'message_name', :with => 'Message Title'
    end
    within('.email') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    find('.submit-form input').click
    assert page.has_content?('Message was successfully sent')
  end

  it 'Fill up all form fields' do
    within('.name') do
      fill_in 'message_name', :with => 'Message Title 1'
    end
    within('.email') do
      fill_in 'message_email', :with => 'asd@rb.ru'
    end
    within('.phone') do
      fill_in 'message_phone', :with => '1234567'
    end
    within('.text') do
      fill_in 'message_text', :with => 'Hi everyone im a newbie'
    end
    find('label', :text => 'RoRoRoRoR').click
    find('label', :text => 'Minimum work project').click
    find('.submit-form input').click
    assert page.has_content?('Message was successfully sent')
  end

end