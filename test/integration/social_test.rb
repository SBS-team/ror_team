require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

class SocialTest < IntegrationTest

  before do

    FactoryGirl.create(:post)
    FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user, :uid => '12345', :provider => 'twitter')

  end

  it "check twitter" do
    visit '/'
    click_link 'Blog'
    sleep(2)
    click_link 'my post'
    sleep(2)
    find('.twitter').click
    sleep(2)
    fill_in 'username_or_email', :with => ''
    fill_in 'session[password]', :with => ''
    click_button 'Авторизовать'
    login_as(@user)
    sleep(2)
    click_link 'my post'
    fill_in 'comment_description', :with => 'Sample comment'
    click_button 'Add comment'
    expect(page).to have_content 'Comment was successfully created.'
  end
end