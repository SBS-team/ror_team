require "minitest_helper"

describe LiveChatsController  do

  before do
    @manager = FactoryGirl.create(:admin_user, :role => 'manager', :status => 'online')
  end

  it 'render new live chat' do
    FactoryGirl.create(:admin_user)
    post :new_chat, :format => 'js'
    assigns(:admins).must_include @manager
    assigns(:admins).length.must_equal 1
    assert_template 'shared/_new_chat'
    assert_response :ok
  end

  it 'create live chat' do
    post :create_chat, live_chat:{:guest_name => 'User', :admin_id => @manager.id}, :message => 'Hello manager :-)', :format => 'js'
    LiveChat.first.guest_name.must_equal 'User'
    LiveChat.first.admin_id = @manager.id
    LiveChat.first.admin_user.status.must_equal 'chat'
    LiveChat.first.chat_messages.count.must_equal 1
    LiveChat.first.chat_messages.first.body.must_equal 'Hello manager :-)'
    assert_template 'shared/_show_chat'
    assert_response :ok
  end

  it 'send massage' do
    post :create_chat, live_chat:{:guest_name => 'User', :admin_id => @manager.id}, :message => 'Hello manager!!!', :format => 'js'
    LiveChat.first.guest_name.must_equal 'User'
    LiveChat.first.chat_messages.count.must_equal 1

    post :send_msg, :message => 'I am User'
    LiveChat.first.chat_messages.count.must_equal 2
    LiveChat.first.chat_messages.last.body.must_equal 'I am User'
    assert_response :ok
  end

  it 'close chat' do
    post :create_chat, live_chat:{:guest_name => 'User', :admin_id => @manager.id}, :message => 'Hello manager!!!', :format => 'js'
    LiveChat.first.guest_name.must_equal 'User'
    LiveChat.first.chat_messages.count.must_equal 1
    post :chat_close, :format => 'js'
    LiveChat.first.admin_user.status.must_equal 'online'
    assert_response :ok
  end

end