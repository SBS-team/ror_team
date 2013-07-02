class UsersController < ApplicationController





  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone, :skype, roles_attributes:[:all])
  end
end
