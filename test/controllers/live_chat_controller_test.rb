require "minitest_helper"

describe LiveChatsController  do

  it 'should get new' do
    get :new
    assert_response :success
  end

  it 'should get show' do
    ch = FactoryGirl.create(:live_chat, :admin_id => FactoryGirl.create(:admin_user, :role => 'manager').id)
    get :show, :id => ch.id
    assert_response :success
  end

end