class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.ban
      sign_out resource
      flash[:error] = 'This account is banned...'
      root_path
    else
      super
    end
  end
end
