require "minitest_helper"

describe AdminChatController do

  before do
    @manager = FactoryGirl.create(:admin_user, :role => 'manager', :status => 'offline')
  end

  it 'get chat' do
    sign_in(@manager)
    get :chat
    assigns(:live_chat).must_be_nil
    assigns(:messages).must_be_nil
    AdminUser.first.status.must_equal 'online'
    assert_template 'admin_chat/chat'
    assert_response :ok
  end

  it 'get chat with LiveChat' do
    man = FactoryGirl.create(:admin_user, :role => 'manager', :status => 'chat')
    sign_in(man)
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
    @manager.status = 'chat'
    sign_in(@manager)
    post :close
    AdminUser.last.status.must_equal 'online'
  end

end