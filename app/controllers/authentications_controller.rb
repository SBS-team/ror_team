class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  #def create
  #  #render :text => request.env["omniauth.auth"].to_yaml
  ##  logger.info '='*1000
  ##  auth = request.env["omniauth.auth"]
  ##  puts auth.inspect
  ##  logger.info '='*1000
  #end

  def create
    auth = request.env["omniauth.auth"]
      logger.info '='*1000
      puts current_user.inspect
      logger.info '='*1000
    #GroupMember.where(:member_id => 4, :group_id => 7).first_or_create
    #@comment = @commentable.comments.new(comment_params)
    #current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to authentications_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end


#User.create(:email => "drkmen@rambler.ru", :password => "123123", :password_confirmation => "123123", :remember_me => false)
