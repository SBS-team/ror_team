require 'minitest_helper'

describe ContactController do

  it 'should get index' do
    get :index
    assert_response :success
  end

  it 'index should render correct template and layout' do
    get :index
    assert_template :index
    assert_template layout: 'layouts/application'
  end

  it 'should send message' do
    post :create, message: {:name => 'Hilli', :email => 'asd@mail.ru'}
    assert_redirected_to root_path
    assert_equal 'Message was successfully sent.', flash[:notice]
  end

  it 'send message errors' do
    post :create, message: {:name => '', :email => 'asd@mail.ru'}
    assigns(:message).errors.wont_be_nil
  end

  it 'initialize_live_chat' do
    chat = LiveChat.create(:guest_name => 'User', :admin_user_id => FactoryGirl.create(:admin_user, :role => 'manager', :status => 'online', :last_activity => DateTime.now).id)
    session[:chat_id] = chat.id
    get :index
    assigns(:live_chat).must_equal chat
  end


end

