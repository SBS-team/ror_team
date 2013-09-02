require 'minitest_helper'

describe AdminChatController do

  before do
    @manager = FactoryGirl.create(:admin_user, :role => 'manager', :busy => false)
  end

  it 'get chat' do
    sign_in @manager
    get :chat
    assigns(:live_chat).must_be_nil
    assigns(:messages).must_be_nil
    assert_template 'admin_chat/chat'
    assert_response :ok
    sign_out @manager

    get :chat
    response.body.must_include 'You must log in as manager'
    assert_response :ok
  end

  it 'get chat with LiveChat' do
    man = FactoryGirl.create(:admin_user, :role => 'manager', :busy => true)
    sign_in man
    chat = FactoryGirl.create(:live_chat, :admin_user_id => man.id)
    get :chat
    assigns(:live_chat).admin_user_id.must_equal man.id
    assert_template 'admin_chat/chat'
    assert_response :ok
  end

  it 'send massage' do
    post :send_msg, :live_chat_id => FactoryGirl.create(:live_chat, :admin_user_id => @manager.id).id, :message => 'I am manager !!!'
    LiveChat.first.chat_messages.last.body.must_equal 'I am manager !!!'
    LiveChat.first.chat_messages.last.is_admin.must_equal true
    assert_response :ok
  end

  it 'close chat' do
    @manager.update_attribute(:busy, true)
    sign_in @manager
    post :close
    AdminUser.last.busy.must_equal false
  end

  it 'go_offline' do
    @manager.update_attribute(:busy, true)
    sign_in @manager
    post :go_offline
    AdminUser.last.busy.must_equal false
    AdminUser.last.last_activity.must_be '<', 10.minutes.ago
  end

end