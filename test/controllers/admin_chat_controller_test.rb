require "minitest_helper"

describe AdminChatController do

  it 'get #chat' do
    current_admin_user = FactoryGirl.create(:admin_user, role: 'manager')
    sign_in(current_admin_user)
    FactoryGirl.create(:live_chat, :admin_id => current_admin_user.id)
    get :chat
    assert_response :success
  end

end