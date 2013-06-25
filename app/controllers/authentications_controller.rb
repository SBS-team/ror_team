class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      #sign_in_and_redirect(:user, authentication.user)
      #sign_in @user
      flash[:notice] = "Signed in successfully."
      redirect_to root_path
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user.save!
      sign_in_and_redirect(:user, user)
      flash[:notice] = "Signed in successfully."
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end


#User.create(:email => "drkmen@rambler.ru", :password => "123123", :password_confirmation => "123123", :remember_me => false)
