require 'minitest_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe ViewTest do

  before do

    @admin = FactoryGirl.create(:admin_user)
    FactoryGirl.create(:post, :admin_id => @admin.id, :upload_file => FactoryGirl.create(:upload_file))
    FactoryGirl.create(:category)

  end

  it "check twitter" do
    visit '/'
    click_link 'Blog'
    sleep(2)
    click_link 'my post'
    sleep(2)
    find('.twitter').click
    sleep(2)
    fill_in 'username_or_email', :with => 'HERE YOU NEED TO WRITE YOUR LOGIN FOR TWITTER'
    fill_in 'session[password]', :with => 'HERE YOU NEED TO WRITE YOUR PASSWORD FOR TWITTER'
    click_button 'Авторизовать'
    sleep(2)
    fill_in 'comment_description', :with => 'Sample comment'
    click_button 'Add Comment'
    assert page.has_content?('Comment was successfully created.')
  end

  it "check facebook" do
    visit '/'
    click_link 'Blog'
    sleep(2)
    click_link 'my post'
    sleep(2)
    user = FactoryGirl.create(:user, :uid => '67890', :provider => 'facebook')
    login_as(user, :scope => :user)
    fill_in 'comment_description', :with => 'Sample comment'
    click_button 'Add Comment'
    assert page.has_content?('Comment was successfully created.')
  end

end