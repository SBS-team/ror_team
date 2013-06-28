class AuthenticationsController < ApplicationController

  #def index
  #  @authentications = current_user.authentications if current_user
  #end

  def create
    omniauth = request.env["omniauth.auth"]
    logger.info '==='*50
    omniauth.inspect
    logger.info '==='*50
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    sign_in user
    redirect_to '/posts'

















    #omniauth = request.env["omniauth.auth"]
    #@image = omniauth["info"]["image"]
    #authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    #
    #logger.info '*'*250
    #puts omniauth.inspect
    #puts omniauth["info"]["name"]
    #puts omniauth["info"]["nickname"]
    #puts omniauth["info"]["image"]
    #logger.info '*'*250
    #
    #if authentication
    #  #sign_in_and_redirect(:user, back)
    #
    #  user = User.joins(:authentications).where('users.id = authentications.user_id')
    #  sign_in user
    #  #User.delete_all
    #  #@user = User.find_or_create_by_id(id: session[:user_id])
    #  #sign_in @user
    #
    #
    #  flash[:notice] = "Signed in successfully."
    #  redirect_to posts_path
    #elsif current_user
    #  current_user.authentications.create!(:provider => omniauth['provider'],
    #                                       :uid => omniauth['uid'],
    #                                       :name => omniauth['info']['name'],
    #                                       :screen_name => omniauth['info']['nickname'])
    #  flash[:notice] = "Authentication successful."
    #  redirect_to authentications_url
    #else
    #  user = User.new
    #  user.authentications.build(:provider => omniauth['provider'],
    #                             :uid => omniauth['uid'],
    #                             :name => omniauth['info']['name'],
    #                             :screen_name => omniauth['info']['nickname'])
    #  user.save(:validate => false)
    #  sign_in_and_redirect(:user, user)
    #  flash[:notice] = "Signed in successfully."
    #end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end


#User.create(:email => "drkmen@rambler.ru", :password => "123123", :password_confirmation => "123123", :remember_me => false)
