class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create

    #render :text => request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      #sign_in_and_redirect(:user, back)
      #@user = User.joins(:authentications).where("user.id = authentication.user_id")
      #session[:user_id, :uid, :provider] = authentication(:user_id, omniauth['uid'], omniauth['provider'])
      #session[:user_id] = authentication(:user_id)
      #session[:name] = omniauth['name']
      #session[:screen_name] = omniauth['screen_name']
      #session[:uid] = omniauth['uid']
      #session[:provider] = omniauth['provider']
      #session[:authenticate] = true
      User.delete_all
      @user = User.find_or_create_by_id(id: session[:user_id])
      sign_in @user


      logger.info '*'*250
      puts session.inspect
      logger.info '-'*50
      puts session[:user_id].inspect
      puts session[:screen_name]
      puts session[:uid]
      logger.info '-'*50
      logger.info '*'*250


      flash[:notice] = "Signed in successfully."
      redirect_to posts_path
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'],
                                           :uid => omniauth['uid'],
                                           :name => omniauth['name'],
                                           :screen_name => omniauth['screen_name'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.authentications.build(:provider => omniauth['provider'],
                                 :uid => omniauth['uid'],
                                 :name => omniauth['name'],
                                 :screen_name => omniauth['screen_name'])
      user.save(:validate => false)
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
