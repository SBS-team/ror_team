require 'minitest_helper'

ApplicationController.skip_before_filter :assign_gon_properties

describe ContactController do

  it 'should get index' do
    get :new
    assert_response :success
  end

  it 'index should render correct template and layout' do
    get :new
    assert_template :new
    assert_template layout: 'layouts/application'
  end

  it 'should send message' do
    post :create, message: {:name => 'Hilli', :email => 'asd@mail.ru'}
    assert_redirected_to root_path
    assert_equal 'Message was successfully sent.', flash[:notice]
    assert_equal '', flash[:error]
  end

  it 'should flash error name' do
    post :create, message: {:email => 'asd@mail.ru'}
    assert_template :new
    assert_equal 'Name cannot be blank.<br/>', flash[:error]
  end

  it 'should flash error email' do
    post :create, message: {:name => 'Andrew'}
    assert_template :new
    assert_equal 'Email cannot be blank.<br/>', flash[:error]
  end

end

