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

end

