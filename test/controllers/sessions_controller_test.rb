require 'minitest_helper'

describe SessionsController do

  it 'Login banned user' do
    user = FactoryGirl.create(:user, :ban => true)
    sign_in user
    user.ban.must_equal true
    assert_response :success
    refute_empty assigns(flash[:error])
  end

end